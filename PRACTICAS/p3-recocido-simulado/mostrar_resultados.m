function mostrar_resultados(mejor_secuencia, mejor_valor, historial_mejores, ...
        d_matrix, criterio, historial_temperaturas, aceptaciones)
    % Mostrar resultados detallados del Recocido Simulado
    
    fprintf('=== RESULTADOS FINALES ===\n');
    fprintf('Mejor secuencia encontrada: ');
    fprintf('%d ', mejor_secuencia);
    fprintf('\n');
    
    if strcmp(criterio, 'max')
        fprintf('Makespan (Fmax) de la mejor solución: %.2f\n', mejor_valor);
    else
        fprintf('Tiempo promedio de flujo (Fmed) de la mejor solución: %.2f\n', mejor_valor);
    end
    
    % Calcular matriz F de la mejor solución
    F_mejor = funcion_F(mejor_secuencia, d_matrix);
    fprintf('\nMatriz F de la mejor solución:\n');
    disp(F_mejor');
    
    % Estadísticas del Recocido Simulado
    fprintf('\n--- ESTADÍSTICAS DEL RECOCIDO SIMULADO ---\n');
    fprintf('Total iteraciones: %d\n', length(historial_mejores));
    fprintf('Temperatura inicial: %.2f\n', historial_temperaturas(1));
    fprintf('Temperatura final: %.6f\n', historial_temperaturas(end));
    fprintf('Mejor valor encontrado: %.2f\n', mejor_valor);
    fprintf('Valor inicial: %.2f\n', historial_mejores(1));
    
    if historial_mejores(1) ~= 0
        fprintf('Mejora relativa: %.2f%%\n', ...
            (historial_mejores(1) - mejor_valor) / historial_mejores(1) * 100);
    else
        fprintf('Mejora relativa: No calculable (valor inicial 0)\n');
    end
    
    fprintf('Aceptaciones por mejora: %d (%.1f%%)\n', ...
        aceptaciones.mejora, aceptaciones.mejora/aceptaciones.total*100);
    fprintf('Aceptaciones por probabilidad: %d (%.1f%%)\n', ...
        aceptaciones.no_mejora, aceptaciones.no_mejora/aceptaciones.total*100);
    fprintf('Tasa total de aceptación: %.1f%%\n', ...
        (aceptaciones.mejora + aceptaciones.no_mejora)/aceptaciones.total*100);
    
    % Mostrar evolución de los mejores valores
    fprintf('\nEvolución de los mejores valores:\n');
    puntos = [1, floor(length(historial_mejores)/4), ...
              floor(length(historial_mejores)/2), length(historial_mejores)];
    puntos = unique(puntos(puntos >= 1 & puntos <= length(historial_mejores)));
    
    for i = 1:length(puntos)
        idx = puntos(i);
        fprintf('Iteración %d: %.2f (T=%.4f)\n', idx, historial_mejores(idx), ...
            historial_temperaturas(idx));
    end
end