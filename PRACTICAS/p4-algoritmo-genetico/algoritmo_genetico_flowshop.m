function [mejor_secuencia, mejor_valor, historial_mejores, historial_promedio, diversidad] = ...
        algoritmo_genetico_flowshop(d_matrix, criterio, tam_poblacion, ...
        num_generaciones, prob_cruce, prob_mutacion, metodo_seleccion)
    % Algoritmo Genético para flowshop permutacional
    
    [num_ordenes, ~] = size(d_matrix);
    historial_mejores = zeros(1, num_generaciones);
    historial_promedio = zeros(1, num_generaciones);
    diversidad = zeros(1, num_generaciones);
    
    % Inicializar población
    poblacion = inicializar_poblacion(tam_poblacion, num_ordenes);
    
    % Verificar población inicial
    for i = 1:size(poblacion, 1)
        if ~verificar_permutacion(poblacion(i, :))
            error('Población inicial contiene permutación inválida');
        end
    end
    
    % Evaluar población inicial
    fitness = evaluar_poblacion(poblacion, d_matrix, criterio);
    
    % Encontrar mejor individuo inicial
    [mejor_valor, mejor_idx] = min(fitness);
    mejor_secuencia = poblacion(mejor_idx, :);
    
    fprintf('Iniciando Algoritmo Genético...\n');
    fprintf('Generación 1 - Mejor: %.2f - Promedio: %.2f\n', ...
        mejor_valor, mean(fitness));
    
    for gen = 1:num_generaciones
        % Selección de padres
        padres = seleccionar(poblacion, fitness, tam_poblacion, metodo_seleccion);
        
        % Cruce
        hijos = cruzar(padres, prob_cruce, num_ordenes);
        
        % Verificar hijos después del cruce
        for i = 1:size(hijos, 1)
            if ~verificar_permutacion(hijos(i, :))
                % Si hay un hijo inválido, regenerarlo como copia de un padre
                hijos(i, :) = padres(i, :);
            end
        end
        
        % Mutación
        hijos = mutar(hijos, prob_mutacion);
        
        % Verificar hijos después de la mutación
        for i = 1:size(hijos, 1)
            if ~verificar_permutacion(hijos(i, :))
                % Si hay un hijo inválido, regenerarlo
                hijos(i, :) = randperm(num_ordenes);
            end
        end
        
        % Evaluar hijos
        fitness_hijos = evaluar_poblacion(hijos, d_matrix, criterio);
        
        % Reemplazo (estrategia elitista)
        [poblacion, fitness] = reemplazar(poblacion, fitness, hijos, fitness_hijos);
        
        % Actualizar mejor solución
        [mejor_gen, mejor_idx] = min(fitness);
        if mejor_gen < mejor_valor
            mejor_valor = mejor_gen;
            mejor_secuencia = poblacion(mejor_idx, :);
        end
        
        % Guardar estadísticas
        historial_mejores(gen) = mejor_valor;
        historial_promedio(gen) = mean(fitness);
        diversidad(gen) = calcular_diversidad(poblacion);
        
        % Mostrar progreso cada 10 generaciones
        if mod(gen, 10) == 0 || gen == 1
            fprintf('Generación %d - Mejor: %.2f - Promedio: %.2f - Diversidad: %.3f\n', ...
                gen, mejor_valor, mean(fitness), diversidad(gen));
        end
    end
    
    fprintf('\nAlgoritmo Genético finalizado.\n');
    fprintf('Mejor solución encontrada en generación %d\n', num_generaciones);
end