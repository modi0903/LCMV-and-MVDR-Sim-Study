function a = steering_vector_ula(array, theta)
%angles are in Radians Strictly
    k = 2*pi / array.lambda;
    a = exp(1j * k * array.positions * sin(theta));
    a = a / sqrt(array.M);  % power normalization
end
