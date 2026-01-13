function w = lcmv_beamformer(R, C, f)
%Linearly Constrained Minimum Variance
%   C : constraint matrix [a_desired, a_int1, ...]
%   f : constraint response vector [1; 0; 0; ...]

    R_inv = pinv(R);
    w = R_inv * C * ((C' * R_inv * C) \ f);
end
