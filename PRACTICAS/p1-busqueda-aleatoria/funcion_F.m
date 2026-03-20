function F = funcion_F(secuencia, d_matrix)
    % Calcular matriz F de tiempos de salida
    
    [num_ordenes, num_maquinas] = size(d_matrix);
    
    % Inicializar matriz F (máquinas x órdenes)
    F = zeros(num_maquinas, num_ordenes);
    
    % Calcular primera máquina
    F(1, 1) = d_matrix(secuencia(1), 1);
    for j = 2:num_ordenes
        F(1, j) = F(1, j-1) + d_matrix(secuencia(j), 1);
    end
    
    % Calcular para las demás máquinas
    for i = 2:num_maquinas
        F(i, 1) = F(i-1, 1) + d_matrix(secuencia(1), i);
        for j = 2:num_ordenes
            F(i, j) = max(F(i-1, j), F(i, j-1)) + d_matrix(secuencia(j), i);
        end
    end
end