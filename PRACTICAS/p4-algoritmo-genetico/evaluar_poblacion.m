function fitness = evaluar_poblacion(poblacion, d_matrix, criterio)
    % Evaluar fitness de toda la población
    
    tam_poblacion = size(poblacion, 1);
    fitness = zeros(tam_poblacion, 1);
    
    for i = 1:tam_poblacion
        fitness(i) = calcular_objetivo(poblacion(i, :), d_matrix, criterio);
    end
end