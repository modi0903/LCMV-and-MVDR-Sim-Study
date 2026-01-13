function Phi = ris_phase_matrix(N, mode, theta_align)
%modes are random, aligned, none 
    switch mode
        case 'random'
            phi = exp(1j * 2*pi*rand(N,1));
        case 'aligned'
            % Simple phase alignment toward desired direction
            n = (0:N-1).';
            phi = exp(-1j * pi * n * sin(theta_align));
        case 'none'
            phi = ones(N,1);
        otherwise
            error('Unknown RIS mode');
    end
    Phi = diag(phi);
end
