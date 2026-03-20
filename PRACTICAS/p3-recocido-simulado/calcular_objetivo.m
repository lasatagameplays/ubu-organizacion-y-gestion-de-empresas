function valor = calcular_objetivo(secuencia, d_matrix, criterio)
    % Calcular función objetivo según el criterio especificado
    
    F = funcion_F(secuencia, d_matrix);
    [num_maquinas, num_ordenes] = size(F);
    
    if strcmp(criterio, 'max')
        % Fmax: makespan (tiempo de finalización de la última orden)
        valor = F(num_maquinas, num_ordenes);
    else
        % Fmed: tiempo promedio de flujo
        valor = mean(F(num_maquinas, :));
    end
end