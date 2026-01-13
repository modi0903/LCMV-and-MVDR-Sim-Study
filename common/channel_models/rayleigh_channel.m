function h = rayleigh_channel(array)
% Rayleigh fading channel
    h = (randn(array.M,1) + 1j*randn(array.M,1)) / sqrt(2);
    h = h / norm(h);
end
