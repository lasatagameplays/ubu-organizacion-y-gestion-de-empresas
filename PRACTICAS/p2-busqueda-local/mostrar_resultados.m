function mostrar_resultados(mejor_secuencia, mejor_valor, historial_mejores, ...
        d_matrix, criterio, iteraciones, vecinos_evaluados)
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
    fprintf('Total iteraciones: %d\n', iteraciones);
    fprintf('Total vecinos evaluados: %d\n', vecinos_evaluados);
    fprintf('Mejor valor encontrado: %.2f\n', mejor_valor);
    fprintf('Valor inicial: %.2f\n', historial_mejores(1));
    
    if historial_mejores(1) ~= 0
        fprintf('Mejora relativa: %.2f%%\n', ...
            (historial_mejores(1) - mejor_valor) / historial_mejores(1) * 100);
    else
        fprintf('Mejora relativa: No calculable (valor inicial 0)\n');
    end
    
    n = length(mejor_secuencia);
    fprintf('Tamaño del vecindario por iteración: %d\n', n*(n-1)/2);
    
    % Mostrar evolución de los mejores valores (CORREGIDO)
    fprintf('\nEvolución de los mejores valores:\n');
    
    % Definir puntos de muestreo seguros
    puntos = unique([1, floor(iteraciones/4), floor(iteraciones/2), iteraciones]);
    puntos = puntos(puntos >= 1 & puntos <= length(historial_mejores));
    
    for i = 1:length(puntos)
        idx = puntos(i);
        fprintf('Iteración %d: %.2f\n', idx, historial_mejores(idx));
    end
end