function h_eff = cascaded_ris_channel(h_br, Phi, h_ru)
%BS–RIS–UE
%h_br BS -> RIS channel vector
%Phi  RIS phase shift diag matrix
%h_ru RIS -> UE channel vector
    h_eff = h_br' * Phi * h_ru;
    h_eff = h_eff(:);
end
