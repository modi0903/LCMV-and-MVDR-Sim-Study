function [h_eff, H_int] = generate_ris_channels(array_bs, params, Phi)
%GENERATE_RIS_CHANNELS Effective BS-RIS-UE channel

    % Convert angles to radians
    theta_bs_ris = params.theta_bs_ris * pi/180;
    theta_int = params.theta_int * pi/180;

    % BS steering toward RIS
    a_bs = steering_vector_ula(array_bs, theta_bs_ris);

    % RIS -> UE channel (Rayleigh)
    h_ru = (randn(params.N_ris,1) + 1j*randn(params.N_ris,1)) / sqrt(2);

    % Effective desired channel (RIS-assisted)
    h_eff = cascaded_ris_channel(a_bs, Phi, h_ru);

    % Interferers (direct BS paths)
    H_int = zeros(array_bs.M, length(theta_int));
    for k = 1:length(theta_int)
        H_int(:,k) = steering_vector_ula(array_bs, theta_int(k));
    end
end
