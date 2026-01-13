function h_eff = cascaded_ris_channel(a_bs, Phi, h_ru)
%CASCADED_RIS_CHANNEL Effective RIS-assisted BS channel
% a_bs : BS steering vector (M x 1)
% Phi  : RIS phase shift diagonal matrix (N x N)
% h_ru : RIS -> UE channel vector (N x 1)

    % RIS-induced scalar gain
    g_ris = h_ru' * Phi * ones(size(h_ru));

    % Effective BS-side channel
    h_eff = g_ris * a_bs;

    % Normalize
    h_eff = h_eff / norm(h_eff);
end
