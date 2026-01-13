clc; clear; close all;

%% Setup
addpath(genpath('../../common'));

params = leo_params();

array_bs = ula_array(params.M_bs, params.d, params.lambda);

%% Channels (initial)
[h_sig_0, H_int_0] = generate_leo_channels(array_bs, params);

%% Snapshot-based covariance
X = zeros(params.M_bs, params.N_snap);

for n = 1:params.N_snap

    % Apply Doppler if enabled
    if params.enable_doppler
        h_sig = apply_doppler(h_sig_0, n, params.doppler_rate);

        H_int = zeros(size(H_int_0));
        for k = 1:size(H_int_0,2)
            H_int(:,k) = apply_doppler(H_int_0(:,k), n, params.doppler_rate);
        end
    else
        h_sig = h_sig_0;
        H_int = H_int_0;
    end

    % Signal
    s = (randn + 1j*randn)/sqrt(2);
    x = h_sig * s;

    % Interference
    for k = 1:size(H_int,2)
        i = (randn + 1j*randn)/sqrt(2);
        x = x + H_int(:,k) * i;
    end

    % Noise
    noise = sqrt(params.sigma2/2) * ...
            (randn(params.M_bs,1)+1j*randn(params.M_bs,1));

    X(:,n) = x + noise;
end

R = (X * X') / params.N_snap;

%% Beamforming (STATIC weights)
a_des = steering_vector_ula(array_bs, params.theta_des*pi/180);

w_mvdr = mvdr_beamformer(R, a_des);

C = [a_des, H_int_0];
f = [1; zeros(size(H_int_0,2),1)];
w_lcmv = lcmv_beamformer(R, C, f);

%% Metrics
sinr_mvdr = compute_sinr(w_mvdr, h_sig_0, H_int_0, params.sigma2);
sinr_lcmv = compute_sinr(w_lcmv, h_sig_0, H_int_0, params.sigma2);

fprintf('LEO scenario\n');
fprintf('Doppler enabled: %d\n', params.enable_doppler);
fprintf('MVDR SINR = %.2f dB\n', 10*log10(sinr_mvdr));
fprintf('LCMV SINR = %.2f dB\n', 10*log10(sinr_lcmv));

%% Beampattern
theta_grid = linspace(10,50,800) * pi/180;

BP_mvdr = compute_beampattern(w_mvdr, array_bs, theta_grid);
BP_lcmv = compute_beampattern(w_lcmv, array_bs, theta_grid);

figure;
plot(theta_grid*180/pi, BP_mvdr, 'LineWidth', 1.5); hold on;
plot(theta_grid*180/pi, BP_lcmv, '--', 'LineWidth', 1.5);
xlabel('Angle (deg)');
ylabel('Beampattern (dB)');
legend('MVDR','LCMV');
grid on;
title('LEO satellite scenario');
