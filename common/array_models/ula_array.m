function array = ula_array(M, d, lambda)
    array.M = M;
    array.d = d;
    array.lambda = lambda;
    array.positions = (0:M-1).' * d;
end
