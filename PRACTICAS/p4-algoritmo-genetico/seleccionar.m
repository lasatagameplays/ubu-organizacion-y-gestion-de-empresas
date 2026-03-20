function padres = seleccionar(poblacion, fitness, tam_poblacion, metodo)
    % Selección de padres
    
    switch metodo
        case 'ruleta'
            padres = seleccion_ruleta(poblacion, fitness, tam_poblacion);
        case 'torneo'
            padres = seleccion_torneo(poblacion, fitness, tam_poblacion);
        otherwise
            error('Método de selección no reconocido');
    end
end

function padres = seleccion_ruleta(poblacion, fitness, tam_poblacion)
    % Selección por ruleta (implementación manual sin randsample)
    
    num_individuos = size(poblacion, 1);
    
    % Convertir fitness a probabilidades (minimización)
    % Para minimización, invertimos los valores
    fitness_ajustado = max(fitness) - fitness + eps;
    probabilidades = fitness_ajustado / sum(fitness_ajustado);
    
    % Crear ruleta acumulativa
    ruleta_acumulativa = cumsum(probabilidades);
    
    % Seleccionar padres
    padres = zeros(tam_poblacion, size(poblacion, 2));
    
    for i = 1:tam_poblacion
        r = rand();
        % Encontrar el índice correspondiente en la ruleta
        idx_seleccionado = find(ruleta_acumulativa >= r, 1);
        if isempty(idx_seleccionado)
            idx_seleccionado = num_individuos; % Por seguridad
        end
        padres(i, :) = poblacion(idx_seleccionado, :);
    end
end

function padres = seleccion_torneo(poblacion, fitness, tam_poblacion)
    % Selección por torneo binario
    
    num_individuos = size(poblacion, 1);
    padres = zeros(tam_poblacion, size(poblacion, 2));
    
    for i = 1:tam_poblacion
        % Seleccionar 2 individuos aleatorios diferentes
        idxs = randperm(num_individuos, 2);
        
        % Escoger el mejor (menor fitness para minimización)
        if fitness(idxs(1)) < fitness(idxs(2))
            padres(i, :) = poblacion(idxs(1), :);
        else
            padres(i, :) = poblacion(idxs(2), :);
        end
    end
end