function mostrar_resultados(mejor_secuencia, mejor_valor, historial_mejores, ...
        d_matrix, criterio, num_generaciones, tamano_poblacion)
    % Mostrar resultados detallados del Algoritmo Genético
    
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
    
    % Estadísticas del Algoritmo Genético
    fprintf('\n--- ESTADÍSTICAS DEL ALGORITMO GENÉTICO ---\n');
    fprintf('Total de generaciones: %d\n', num_generaciones);
    fprintf('Tamaño de población: %d\n', tamano_poblacion);
    fprintf('Mejor valor encontrado: %.2f\n', mejor_valor);
    fprintf('Valor inicial: %.2f\n', historial_mejores(1));
    
    if historial_mejores(1) ~= 0
        fprintf('Mejora relativa: %.2f%%\n', ...
            (historial_mejores(1) - mejor_valor) / historial_mejores(1) * 100);
    else
        fprintf('Mejora relativa: No calculable (valor inicial 0)\n');
    end
    
    % Mostrar evolución
    fprintf('\nEvolución del mejor valor:\n');
    puntos = [1, floor(num_generaciones/4), floor(num_generaciones/2), num_generaciones];
    puntos = unique(puntos(puntos >= 1 & puntos <= num_generaciones));
    
    for i = 1:length(puntos)
        idx = puntos(i);
        fprintf('Generación %d: %.2f\n', idx, historial_mejores(idx));
    end
end