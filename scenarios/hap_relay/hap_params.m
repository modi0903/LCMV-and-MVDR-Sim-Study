function params = hap_params()
    params.lambda = 1;
    params.M_bs = 8;
    params.d = params.lambda/2;
    % Angles (degrees)
    params.theta_des = 75;                 % high elevation
    params.theta_int = [74.5 75.5];            % closely spaced interferers
    % Channel
    params.K_factor = 15;                  % strong LoS dominance
    % Noise
    params.sigma2 = 0.01;
    % Snapshots
    params.N_snap = 40;
end
