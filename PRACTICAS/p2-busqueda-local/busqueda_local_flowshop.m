function [mejor_secuencia, mejor_valor, historial_mejores, iteraciones, vecinos_evaluados] = ...
        busqueda_local_flowshop(d_matrix, criterio, max_iteraciones_sin_mejora)
    % Búsqueda local - Primer Mejor para flowshop permutacional
    
    [num_ordenes, ~] = size(d_matrix);
    historial_mejores = [];
    vecinos_evaluados = 0;
    
    % Inicializar con una solución aleatoria
    corriente_secuencia = randperm(num_ordenes);
    corriente_valor = calcular_objetivo(corriente_secuencia, d_matrix, criterio);
    
    mejor_secuencia = corriente_secuencia;
    mejor_valor = corriente_valor;
    
    historial_mejores(1) = mejor_valor;
    
    fprintf('Iniciando búsqueda local (Primer Mejor)...\n');
    fprintf('Solución inicial - Valor: %.2f\n', corriente_valor);
    
    iteraciones = 1;
    iteraciones_sin_mejora = 0;
    hubo_mejora = true;
    
    while iteraciones_sin_mejora < max_iteraciones_sin_mejora && hubo_mejora
        hubo_mejora = false;
        
        % Generar vecindario mediante intercambios de 2-opt
        vecindario = generar_vecindario(corriente_secuencia);
        
        % Evaluar vecinos en orden aleatorio (estrategia primer mejor)
        orden_evaluacion = randperm(size(vecindario, 1));
        
        for i = 1:length(orden_evaluacion)
            idx = orden_evaluacion(i);
            vecino_secuencia = vecindario(idx, :);
            vecino_valor = calcular_objetivo(vecino_secuencia, d_matrix, criterio);
            vecinos_evaluados = vecinos_evaluados + 1;
            
            % Criterio de minimización
            if vecino_valor < corriente_valor
                % Encontramos un vecino mejor - primer mejora
                corriente_secuencia = vecino_secuencia;
                corriente_valor = vecino_valor;
                hubo_mejora = true;
                
                % Actualizar mejor global si es necesario
                if corriente_valor < mejor_valor
                    mejor_secuencia = corriente_secuencia;
                    mejor_valor = corriente_valor;
                    iteraciones_sin_mejora = 0;
                    fprintf('Iteración %d - Nuevo mejor: %.2f\n', iteraciones, mejor_valor);
                end
                
                break; % Salir del vecindario al encontrar primera mejora
            end
        end
        
        if ~hubo_mejora
            iteraciones_sin_mejora = iteraciones_sin_mejora + 1;
        else
            iteraciones_sin_mejora = 0;
        end
        
        % Asegurar que el historial tenga al menos un elemento
        if isempty(historial_mejores)
            historial_mejores(1) = mejor_valor;
        else
            historial_mejores(end+1) = mejor_valor;
        end
        
        iteraciones = iteraciones + 1;
        
        % Mostrar progreso cada 10 iteraciones
        if mod(iteraciones, 10) == 0
            fprintf('Iteración %d - Mejor valor: %.2f - Vecinos evaluados: %d\n', ...
                iteraciones, mejor_valor, vecinos_evaluados);
        end
        
        % Prevenir bucle infinito (máximo de seguridad)
        if iteraciones > 1000
            fprintf('Alcanzado máximo de iteraciones de seguridad (1000)\n');
            break;
        end
    end
    
    fprintf('\nBúsqueda local finalizada.\n');
    fprintf('Total iteraciones: %d\n', iteraciones);
    fprintf('Total vecinos evaluados: %d\n', vecinos_evaluados);
    fprintf('Iteraciones sin mejora: %d\n\n', iteraciones_sin_mejora);
end