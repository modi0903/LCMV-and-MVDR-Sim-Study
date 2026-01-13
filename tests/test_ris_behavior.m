%test proves monotonic trends, none<random<aligned
clc; clear;

addpath(genpath('../common'));
addpath(genpath('../scenarios/ris_assisted'));

modes = {'none','random','aligned'};
sinr_mvdr = zeros(1,3);
sinr_lcmv = zeros(1,3);

for i = 1:3
    params = ris_params();
    array_bs = ula_array(params.M_bs, params.d, params.lambda);

    Phi = ris_phase_matrix(params.N_ris, modes{i}, params.theta_ris_ue*pi/180);
    [h_sig, H_int] = generate_ris_channels(array_bs, params, Phi);

    X = zeros(params.M_bs, params.N_snap);
    for n = 1:params.N_snap
        x = h_sig*(randn+1j*randn)/sqrt(2);
        for k = 1:size(H_int,2)
            x = x + H_int(:,k)*(randn+1j*randn)/sqrt(2);
        end
        x = x + sqrt(params.sigma2/2)*(randn(params.M_bs,1)+1j*randn(params.M_bs,1));
        X(:,n) = x;
    end

    R = (X*X')/params.N_snap;

    w_mvdr = mvdr_beamformer(R, h_sig);
    w_lcmv = lcmv_beamformer(R, [h_sig H_int], [1;0;0]);

    sinr_mvdr(i) = compute_sinr(w_mvdr, h_sig, H_int, params.sigma2);
    sinr_lcmv(i) = compute_sinr(w_lcmv, h_sig, H_int, params.sigma2);

    fprintf('%s: MVDR=%.2f dB, LCMV=%.2f dB\n', ...
        modes{i}, 10*log10(sinr_mvdr(i)), 10*log10(sinr_lcmv(i)));
end
