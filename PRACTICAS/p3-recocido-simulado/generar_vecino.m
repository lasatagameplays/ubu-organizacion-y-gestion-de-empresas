function vecino = generar_vecino(secuencia)
    % Generar un vecino mediante intercambio de dos posiciones aleatorias
    
    n = length(secuencia);
    vecino = secuencia;
    
    % Seleccionar dos posiciones diferentes aleatorias
    posiciones = randperm(n, 2);
    i = posiciones(1);
    j = posiciones(2);
    
    % Intercambiar las posiciones
    vecino([i, j]) = vecino([j, i]);
end