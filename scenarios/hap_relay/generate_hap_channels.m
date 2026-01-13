function [h_sig, H_int] = generate_hap_channels(array, params)
%HAP-dominated channels
    % Convert angles
    theta_des = params.theta_des * pi/180;
    theta_int = params.theta_int * pi/180;
    % Desired channel (Rician, strong LoS)
    h_sig = rician_channel(array, theta_des, params.K_factor);
    % Interferers (also LoS-dominant)
    H_int = zeros(array.M, length(theta_int));
    for k = 1:length(theta_int)
        H_int(:,k) = rician_channel(array, theta_int(k), params.K_factor);
    end
end
