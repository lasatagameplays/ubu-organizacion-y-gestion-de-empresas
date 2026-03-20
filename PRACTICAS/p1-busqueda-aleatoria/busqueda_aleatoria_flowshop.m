function [mejor_secuencia, mejor_valor, historial_mejores] = busqueda_aleatoria_flowshop(...
        d_matrix, num_iteraciones, criterio)
    % Búsqueda aleatoria simple para flowshop permutacional
    
    [num_ordenes, ~] = size(d_matrix);
    historial_mejores = zeros(1, num_iteraciones);
    
    % Inicializar con una solución aleatoria
    mejor_secuencia = randperm(num_ordenes);
    mejor_valor = calcular_objetivo(mejor_secuencia, d_matrix, criterio);
    historial_mejores(1) = mejor_valor;
    
    fprintf('Iniciando búsqueda aleatoria...\n');
    
    for iter = 2:num_iteraciones
        % Generar nueva solución aleatoria
        nueva_secuencia = randperm(num_ordenes);
        nuevo_valor = calcular_objetivo(nueva_secuencia, d_matrix, criterio);
        
        % Actualizar mejor solución si es necesario
        if strcmp(criterio, 'max')
            % Minimizar Fmax (makespan)
            if nuevo_valor < mejor_valor
                mejor_secuencia = nueva_secuencia;
                mejor_valor = nuevo_valor;
            end
        else
            % Minimizar Fmed (tiempo promedio de flujo)
            if nuevo_valor < mejor_valor
                mejor_secuencia = nueva_secuencia;
                mejor_valor = nuevo_valor;
            end
        end
        
        historial_mejores(iter) = mejor_valor;
        
        % Mostrar progreso cada 10% de las iteraciones
        if mod(iter, max(1, floor(num_iteraciones/10))) == 0
            fprintf('Iteración %d/%d - Mejor valor: %.2f\n', iter, num_iteraciones, mejor_valor);
        end
    end
    
    fprintf('Búsqueda completada.\n\n');
end