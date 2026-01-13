clc; clear; close all;

%% Parameters
lambda = 1;
M = 8;
d = lambda/2;

theta_des = 20 * pi/180;
theta_int = [-30 50] * pi/180;

sigma2 = 0.01;

%% Array
array = ula_array(M, d, lambda);

%% Channels
h_des = los_channel(array, theta_des);

H_int = zeros(M, length(theta_int));
for k = 1:length(theta_int)
    H_int(:,k) = los_channel(array, theta_int(k));
end

%% Snapshot-based covariance
N_snap = 300;
X = zeros(M, N_snap);

for n = 1:N_snap
    s = (randn + 1j*randn)/sqrt(2);
    x = h_des * s;

    for k = 1:size(H_int,2)
        i = (randn + 1j*randn)/sqrt(2);
        x = x + H_int(:,k) * i;
    end

    noise = sqrt(sigma2/2)*(randn(M,1)+1j*randn(M,1));
    X(:,n) = x + noise;
end

R = (X * X') / N_snap;

%% Beamformers
a_des = steering_vector_ula(array, theta_des);

w_mvdr = mvdr_beamformer(R, a_des);

C = [a_des, H_int];
f = [1; 0; 0];
w_lcmv = lcmv_beamformer(R, C, f);

%% Metrics
sinr_mvdr = compute_sinr(w_mvdr, h_des, H_int, sigma2);
sinr_lcmv = compute_sinr(w_lcmv, h_des, H_int, sigma2);

fprintf('MVDR SINR  = %.2f dB\n', 10*log10(sinr_mvdr));
fprintf('LCMV SINR  = %.2f dB\n', 10*log10(sinr_lcmv));

%% Beampattern
theta_grid = linspace(-90,90,1000) * pi/180;

BP_mvdr = compute_beampattern(w_mvdr, array, theta_grid);
BP_lcmv = compute_beampattern(w_lcmv, array, theta_grid);

figure;
plot(theta_grid*180/pi, BP_mvdr, 'LineWidth', 1.5); hold on;
plot(theta_grid*180/pi, BP_lcmv, '--', 'LineWidth', 1.5);
xlabel('Angle (deg)');
ylabel('Beampattern (dB)');
legend('MVDR','LCMV');
grid on;
