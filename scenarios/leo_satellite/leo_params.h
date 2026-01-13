function params = leo_params()
    params.lambda = 1;
    params.M_bs = 8;
    params.d = params.lambda/2;

    % Angles (degrees)
    params.theta_des = 30;
    params.theta_int = [26 34];    % close interferers

    % Channel
    params.K_factor = 20;          % v strong LoS

    % Doppler abstraction
    params.enable_doppler = true;  % <-- switch this for different cases (w / wo doppler)
    params.doppler_rate = 0.02;    % radians per snapshot

    % Noise
    params.sigma2 = 0.01;

    % Snapshots
    params.N_snap = 400;
end
