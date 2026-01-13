function BP = compute_beampattern(w, array, theta_grid)
    BP = zeros(size(theta_grid));
    for i = 1:length(theta_grid)
        a = steering_vector_ula(array, theta_grid(i));
        BP(i) = abs(w' * a);
    end
    BP = 20*log10(BP / max(BP));
end
