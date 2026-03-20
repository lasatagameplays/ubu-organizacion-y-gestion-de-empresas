function vecindario = generar_vecindario(secuencia)
    % Generar vecindario mediante intercambios de pares (2-opt)
    
    n = length(secuencia);
    vecindario = zeros(n*(n-1)/2, n);
    
    idx = 1;
    for i = 1:n-1
        for j = i+1:n
            % Crear nuevo vecino intercambiando posiciones i y j
            vecino = secuencia;
            vecino([i, j]) = vecino([j, i]);
            vecindario(idx, :) = vecino;
            idx = idx + 1;
        end
    end
end