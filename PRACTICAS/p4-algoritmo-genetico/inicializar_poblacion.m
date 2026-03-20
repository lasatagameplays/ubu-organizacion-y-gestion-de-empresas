function poblacion = inicializar_poblacion(tam_poblacion, num_ordenes)
    % Inicializar población con permutaciones aleatorias
    
    poblacion = zeros(tam_poblacion, num_ordenes);
    for i = 1:tam_poblacion
        poblacion(i, :) = randperm(num_ordenes);
    end
end