function [mejor_secuencia, mejor_valor, historial_mejores, historial_temperaturas, aceptaciones] = ...
        recocido_simulado_flowshop(d_matrix, criterio, T_inicial, T_final, ...
        iter_por_temp, factor_enfriamiento)
    % Recocido Simulado para flowshop permutacional
    
    [num_ordenes, ~] = size(d_matrix);
    historial_mejores = [];
    historial_temperaturas = [];
    aceptaciones = struct('mejora', 0, 'no_mejora', 0, 'total', 0);
    
    % Inicializar con una solución aleatoria
    corriente_secuencia = randperm(num_ordenes);
    corriente_valor = calcular_objetivo(corriente_secuencia, d_matrix, criterio);
    
    mejor_secuencia = corriente_secuencia;
    mejor_valor = corriente_valor;
    
    historial_mejores(1) = mejor_valor;
    historial_temperaturas(1) = T_inicial;
    
    fprintf('Iniciando Recocido Simulado...\n');
    fprintf('Solución inicial - Valor: %.2f\n', corriente_valor);
    
    T = T_inicial;
    iteracion_total = 1;
    
    while T > T_final
        aceptaciones_temp = 0;
        
        for iter = 1:iter_por_temp
            % Generar vecino mediante intercambio aleatorio
            vecino_secuencia = generar_vecino(corriente_secuencia);
            vecino_valor = calcular_objetivo(vecino_secuencia, d_matrix, criterio);
            
            % Calcular diferencia de energía
            delta = vecino_valor - corriente_valor;
            
            % Criterio de aceptación
            if delta < 0
                % Aceptar siempre mejoras
                corriente_secuencia = vecino_secuencia;
                corriente_valor = vecino_valor;
                aceptaciones.mejora = aceptaciones.mejora + 1;
                aceptaciones_temp = aceptaciones_temp + 1;
                
                % Actualizar mejor global
                if corriente_valor < mejor_valor
                    mejor_secuencia = corriente_secuencia;
                    mejor_valor = corriente_valor;
                    fprintf('T=%.4f - Nuevo mejor: %.2f\n', T, mejor_valor);
                end
            else
                % Aceptar empeoramiento con probabilidad Boltzmann
                probabilidad = exp(-delta / T);
                if rand() < probabilidad
                    corriente_secuencia = vecino_secuencia;
                    corriente_valor = vecino_valor;
                    aceptaciones.no_mejora = aceptaciones.no_mejora + 1;
                    aceptaciones_temp = aceptaciones_temp + 1;
                end
            end
            
            aceptaciones.total = aceptaciones.total + 1;
            historial_mejores(end+1) = mejor_valor;
            historial_temperaturas(end+1) = T;
            iteracion_total = iteracion_total + 1;
        end
        
        % Mostrar progreso
        tasa_aceptacion = aceptaciones_temp / iter_por_temp * 100;
        fprintf('T=%.4f - Mejor: %.2f - Aceptación: %.1f%% - Iteración: %d\n', ...
            T, mejor_valor, tasa_aceptacion, iteracion_total);
        
        % Enfriar temperatura
        T = T * factor_enfriamiento;
        
        % Condición de parada adicional si no hay mejoras significativas
        if iteracion_total > 10000
            fprintf('Alcanzado máximo de iteraciones totales (10000)\n');
            break;
        end
    end
    
    fprintf('\nRecocido Simulado finalizado.\n');
    fprintf('Total iteraciones: %d\n', iteracion_total);
    fprintf('Temperatura final: %.6f\n', T);
    fprintf('Aceptaciones por mejora: %d (%.1f%%)\n', ...
        aceptaciones.mejora, aceptaciones.mejora/aceptaciones.total*100);
    fprintf('Aceptaciones por probabilidad: %d (%.1f%%)\n\n', ...
        aceptaciones.no_mejora, aceptaciones.no_mejora/aceptaciones.total*100);
end