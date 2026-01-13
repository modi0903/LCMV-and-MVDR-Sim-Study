function w = mvdr_beamformer(R, a_desired)
%Minimum Variance Distortionless Response
    R_inv = pinv(R);
    w = R_inv * a_desired;
    w = w / (a_desired' * R_inv * a_desired);
end
