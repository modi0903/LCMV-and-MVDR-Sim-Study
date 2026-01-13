clc; clear; close all;

addpath(genpath('../../common'));
params = ris_params();
array_bs = ula_array(params.M_bs, params.d, params.lambda);

%% RIS configuration
ris_mode = 'aligned';   % 'none' | 'random' | 'aligned'
Phi = ris_phase_matrix(params.N_ris, ris_mode, ...
                       params.theta_ris_ue * pi/180);

%% Channels
[h_sig, H_int] = generate_ris_channels(array_bs, params, Phi);

%% Snapshot-based covariance
X = zeros(params.M_bs, params.N_snap);

for n = 1:params.N_snap
    s = (randn + 1j*randn)/sqrt(2);
    x = h_sig * s;

    for k = 1:size(H_int,2)
        i = (randn + 1j*randn)/sqrt(2);
        x = x + H_int(:,k) * i;
    end

    noise = sqrt(params.sigma2/2) * ...
            (randn(params.M_bs,1)+1j*randn(params.M_bs,1));

    X(:,n) = x + noise;
end

R = (X * X') / params.N_snap;

%% Beamforming
a_des = h_sig;  % effective steering

w_mvdr = mvdr_beamformer(R, a_des);

C = [a_des, H_int];
f = [1; zeros(size(H_int,2),1)];
w_lcmv = lcmv_beamformer(R, C, f);

%% Metrics
sinr_mvdr = compute_sinr(w_mvdr, h_sig, H_int, params.sigma2);
sinr_lcmv = compute_sinr(w_lcmv, h_sig, H_int, params.sigma2);

fprintf('RIS mode: %s\n', ris_mode);
fprintf('MVDR SINR = %.2f dB\n', 10*log10(sinr_mvdr));
fprintf('LCMV SINR = %.2f dB\n', 10*log10(sinr_lcmv));

%% Beampattern
theta_grid = linspace(-90,90,1000) * pi/180;

BP_mvdr = compute_beampattern(w_mvdr, array_bs, theta_grid);
BP_lcmv = compute_beampattern(w_lcmv, array_bs, theta_grid);

figure;
plot(theta_grid*180/pi, BP_mvdr, 'LineWidth', 1.5); hold on;
plot(theta_grid*180/pi, BP_lcmv, '--', 'LineWidth', 1.5);
xlabel('Angle (deg)');
ylabel('Beampattern (dB)');
legend('MVDR','LCMV');
grid on;
title(['RIS-assisted link (', ris_mode, ')']);
