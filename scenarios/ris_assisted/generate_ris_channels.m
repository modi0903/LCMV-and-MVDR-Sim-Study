function [h_eff, H_int] = generate_ris_channels(array_bs, params, Phi)
    theta_bs_ris = params.theta_bs_ris * pi/180;
    theta_ris_ue = params.theta_ris_ue * pi/180;
    theta_int = params.theta_int * pi/180;
    h_br = steering_vector_ula(array_bs, theta_bs_ris);
    h_ru = (randn(params.N_ris,1) + 1j*randn(params.N_ris,1)) / sqrt(2);
    h_eff = cascaded_ris_channel(h_br, Phi, h_ru);
    h_eff = h_eff / norm(h_eff);
    H_int = zeros(array_bs.M, length(theta_int));
    for k = 1:length(theta_int)
        H_int(:,k) = steering_vector_ula(array_bs, theta_int(k));
    end
end
