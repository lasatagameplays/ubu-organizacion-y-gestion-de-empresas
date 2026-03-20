function visualizar_progreso(historial_mejores, criterio, iteraciones)
    % Visualizar el progreso de la búsqueda
    
    % Asegurar que el historial no esté vacío
    if isempty(historial_mejores)
        fprintf('Historial de mejoras vacío. No se puede generar gráfico.\n');
        return;
    end
    
    figure;
    plot(1:length(historial_mejores), historial_mejores, 'b-', 'LineWidth', 2);
    
    if strcmp(criterio, 'max')
        titulo = 'Evolución del Makespan (Fmax) - Búsqueda Local';
        ylabel('Makespan');
    else
        titulo = 'Evolución del Tiempo Promedio de Flujo (Fmed) - Búsqueda Local';
        ylabel('Tiempo Promedio de Flujo');
    end
    
    title(titulo);
    xlabel('Iteración');
    grid on;
    
    % Añadir línea del mejor valor final
    hold on;
    mejor_final = min(historial_mejores); % Para criterio de minimización
    yline(mejor_final, 'r--', 'LineWidth', 1.5, ...
        'Label', sprintf('Mejor: %.2f', mejor_final));
    legend('Progreso', 'Mejor solución', 'Location', 'best');
    hold off;
end