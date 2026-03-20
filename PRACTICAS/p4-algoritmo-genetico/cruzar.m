function hijos = cruzar(padres, prob_cruce, num_ordenes)
    % Operador de cruce OX (Order Crossover)
    
    num_padres = size(padres, 1);
    hijos = padres; % Por defecto, copiar padres
    
    for i = 1:2:num_padres-1
        if rand() < prob_cruce
            % Aplicar cruce OX
            hijo1 = cruce_OX(padres(i, :), padres(i+1, :));
            hijo2 = cruce_OX(padres(i+1, :), padres(i, :));
            
            hijos(i, :) = hijo1;
            hijos(i+1, :) = hijo2;
        end
    end
end

function hijo = cruce_OX(padre1, padre2)
    % Cruce Order Crossover para permutaciones (versión mejorada)
    
    n = length(padre1);
    
    % Seleccionar dos puntos de corte aleatorios
    puntos = sort(randperm(n, 2));
    inicio = puntos(1);
    fin = puntos(2);
    
    % Inicializar hijo con ceros
    hijo = zeros(1, n);
    
    % Copiar segmento del padre1 al hijo
    hijo(inicio:fin) = padre1(inicio:fin);
    
    % Completar con elementos del padre2 que no están en el segmento copiado
    elementos_restantes = padre2(~ismember(padre2, hijo));
    
    % Colocar elementos restantes en las posiciones vacías
    posiciones_vacias = find(hijo == 0);
    hijo(posiciones_vacias) = elementos_restantes;
end