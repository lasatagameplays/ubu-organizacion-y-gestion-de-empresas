function mostrar_resultados(mejor_secuencia, mejor_valor, historial_mejores, ...
        d_matrix, criterio, num_iteraciones)
    % Mostrar resultados detallados de la búsqueda
    
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
    
    % Estadísticas de la búsqueda
    fprintf('\n--- ESTADÍSTICAS DE LA BÚSQUEDA ---\n');
    fprintf('Número total de iteraciones: %d\n', num_iteraciones);
    fprintf('Mejor valor encontrado: %.2f\n', mejor_valor);
    fprintf('Valor inicial: %.2f\n', historial_mejores(1));
    fprintf('Mejora relativa: %.2f%%\n', ...
        (historial_mejores(1) - mejor_valor) / historial_mejores(1) * 100);
    
    % Mostrar evolución de los mejores valores
    fprintf('\nEvolución de los mejores valores:\n');
    fprintf('Iteración 1: %.2f\n', historial_mejores(1));
    fprintf('Iteración %d: %.2f\n', floor(num_iteraciones/4), ...
        historial_mejores(floor(num_iteraciones/4)));
    fprintf('Iteración %d: %.2f\n', floor(num_iteraciones/2), ...
        historial_mejores(floor(num_iteraciones/2)));
    fprintf('Iteración %d: %.2f\n', num_iteraciones, historial_mejores(end));
end