function visualizar_progreso(historial_mejores, historial_temperaturas, criterio)
    % Visualizar el progreso del Recocido Simulado
    
    if isempty(historial_mejores) || isempty(historial_temperaturas)
        fprintf('Historial vacío. No se puede generar gráfico.\n');
        return;
    end
    
    % Crear figura con dos subplots
    figure('Position', [100, 100, 1200, 800]);
    
    % Subplot 1: Evolución del valor objetivo
    subplot(2, 1, 1);
    plot(1:length(historial_mejores), historial_mejores, 'b-', 'LineWidth', 1.5);
    
    if strcmp(criterio, 'max')
        titulo = 'Evolución del Makespan (Fmax) - Recocido Simulado';
        ylabel('Makespan');
    else
        titulo = 'Evolución del Tiempo Promedio de Flujo (Fmed) - Recocido Simulado';
        ylabel('Tiempo Promedio de Flujo');
    end
    
    title(titulo);
    xlabel('Iteración');
    grid on;
    
    % Añadir línea del mejor valor final
    hold on;
    mejor_final = min(historial_mejores);
    yline(mejor_final, 'r--', 'LineWidth', 1.5, ...
        'Label', sprintf('Mejor: %.2f', mejor_final));
    legend('Progreso', 'Mejor solución', 'Location', 'best');
    hold off;
    
    % Subplot 2: Evolución de la temperatura
    subplot(2, 1, 2);
    semilogy(1:length(historial_temperaturas), historial_temperaturas, 'r-', 'LineWidth', 1.5);
    title('Evolución de la Temperatura');
    xlabel('Iteración');
    ylabel('Temperatura (escala logarítmica)');
    grid on;
    
    % Añadir línea de temperatura final
    hold on;
    yline(historial_temperaturas(end), 'g--', 'LineWidth', 1, ...
        'Label', sprintf('Final: %.6f', historial_temperaturas(end)));
    legend('Temperatura', 'Temperatura final', 'Location', 'best');
    hold off;
end