function div = calcular_diversidad(poblacion)
    % Calcular diversidad de la población
    
    tam_poblacion = size(poblacion, 1);
    if tam_poblacion == 1
        div = 0;
        return;
    end
    
    distancias = zeros(tam_poblacion);
    
    for i = 1:tam_poblacion
        for j = i+1:tam_poblacion
            % Distancia de Hamming para permutaciones
            distancias(i, j) = sum(poblacion(i, :) ~= poblacion(j, :)) / length(poblacion(i, :));
        end
    end
    
    div = mean(nonzeros(distancias));
end