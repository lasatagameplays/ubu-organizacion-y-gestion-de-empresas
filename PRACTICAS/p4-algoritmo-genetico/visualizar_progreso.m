function visualizar_progreso(historial_mejores, historial_promedio, diversidad, criterio)
    % Visualizar el progreso del Algoritmo Genético
    
    if isempty(historial_mejores)
        fprintf('Historial vacío. No se puede generar gráfico.\n');
        return;
    end
    
    % Crear figura con subplots
    figure('Position', [100, 100, 1200, 900]);
    
    % Subplot 1: Evolución del fitness
    subplot(2, 1, 1);
    plot(1:length(historial_mejores), historial_mejores, 'b-', 'LineWidth', 2);
    hold on;
    plot(1:length(historial_promedio), historial_promedio, 'g-', 'LineWidth', 1.5);
    
    if strcmp(criterio, 'max')
        titulo = 'Evolución del Fitness - Algoritmo Genético';
        ylabel('Fitness (Makespan)');
    else
        titulo = 'Evolución del Fitness - Algoritmo Genético';
        ylabel('Fitness (Tiempo Promedio)');
    end
    
    title(titulo);
    xlabel('Generación');
    grid on;
    
    % Añadir línea del mejor valor final
    mejor_final = min(historial_mejores);
    yline(mejor_final, 'r--', 'LineWidth', 1.5, ...
        'Label', sprintf('Mejor: %.2f', mejor_final));
    legend('Mejor', 'Promedio', 'Mejor solución', 'Location', 'best');
    hold off;
    
    % Subplot 2: Diversidad de la población
    subplot(2, 1, 2);
    plot(1:length(diversidad), diversidad, 'm-', 'LineWidth', 1.5);
    title('Diversidad de la Población');
    xlabel('Generación');
    ylabel('Diversidad');
    grid on;
    
    % Añadir línea de diversidad promedio
    div_promedio = mean(diversidad);
    hold on;
    yline(div_promedio, 'k--', 'LineWidth', 1, ...
        'Label', sprintf('Promedio: %.3f', div_promedio));
    legend('Diversidad', 'Diversidad promedio', 'Location', 'best');
    hold off;
end