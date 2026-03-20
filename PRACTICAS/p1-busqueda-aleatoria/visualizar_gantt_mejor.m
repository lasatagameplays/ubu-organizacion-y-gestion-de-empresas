function visualizar_gantt_mejor(F, secuencia, d_matrix, mejor_valor)
    % Visualizar diagrama de Gantt de la mejor solución encontrada
    
    [num_maquinas, num_ordenes] = size(F);
    
    figure;
    hold on;
    
    colores = hsv(num_ordenes);
    
    for i = 1:num_maquinas
        for j = 1:num_ordenes
            % Calcular tiempo de inicio
            if j == 1
                if i == 1
                    inicio = 0;
                else
                    inicio = F(i-1, 1);
                end
            else
                if i == 1
                    inicio = F(i, j-1);
                else
                    inicio = max(F(i, j-1), F(i-1, j));
                end
            end
            
            fin = F(i, j);
            duracion = fin - inicio;
            
            % Dibujar el rectángulo
            rectangle('Position', [inicio, i-0.4, duracion, 0.8], ...
                     'FaceColor', colores(secuencia(j),:), ...
                     'EdgeColor', 'black');
            
            % Texto con el número de orden
            text(inicio + duracion/2, i, sprintf('O%d', secuencia(j)), ...
                'HorizontalAlignment', 'center', 'FontWeight', 'bold', ...
                'Color', 'white', 'FontSize', 9);
        end
    end
    
    ylabel('Máquinas');
    xlabel('Tiempo');
    title(sprintf('Diagrama de Gantt - Mejor Solución (Valor: %.2f)', mejor_valor));
    yticks(1:num_maquinas);
    yticklabels(arrayfun(@(x) sprintf('M%d', x), 1:num_maquinas, 'UniformOutput', false));
    grid on;
    
    % Crear leyenda
    legend_labels = arrayfun(@(x) sprintf('Orden %d', x), secuencia, 'UniformOutput', false);
    legend(legend_labels, 'Location', 'eastoutside');
    
    hold off;
end