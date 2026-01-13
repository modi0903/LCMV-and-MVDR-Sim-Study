function h = rician_channel(array, theta, K)
%Rician fading channel
%K : Rician K-factor (linear)

    h_los = steering_vector_ula(array, theta);
    h_nlos = (randn(array.M,1) + 1j*randn(array.M,1)) / sqrt(2);

    h = sqrt(K/(K+1))*h_los + sqrt(1/(K+1))*h_nlos;
    h = h / norm(h);
end
