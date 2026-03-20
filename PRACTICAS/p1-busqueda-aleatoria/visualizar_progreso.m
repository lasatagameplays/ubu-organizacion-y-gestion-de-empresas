function visualizar_progreso(historial_mejores, criterio, num_iteraciones)
    % Visualizar el progreso de la búsqueda
    
    figure;
    plot(1:num_iteraciones, historial_mejores, 'b-', 'LineWidth', 2);
    
    if strcmp(criterio, 'max')
        titulo = 'Evolución del Makespan (Fmax)';
        ylabel('Makespan');
    else
        titulo = 'Evolución del Tiempo Promedio de Flujo (Fmed)';
        ylabel('Tiempo Promedio de Flujo');
    end
    
    title(titulo);
    xlabel('Iteración');
    grid on;
    
    % Añadir línea del mejor valor final
    hold on;
    yline(historial_mejores(end), 'r--', 'LineWidth', 1.5, ...
        'Label', sprintf('Mejor: %.2f', historial_mejores(end)));
    legend('Progreso', 'Mejor solución', 'Location', 'best');
    hold off;
end