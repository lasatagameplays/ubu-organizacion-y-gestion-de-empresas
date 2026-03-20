function hijos = mutar(hijos, prob_mutacion)
    % Operador de mutación por intercambio
    
    for i = 1:size(hijos, 1)
        if rand() < prob_mutacion
            % Mutación por intercambio de dos elementos
            n = size(hijos, 2);
            posiciones = randperm(n, 2);
            
            % Intercambiar posiciones
            temp = hijos(i, posiciones(1));
            hijos(i, posiciones(1)) = hijos(i, posiciones(2));
            hijos(i, posiciones(2)) = temp;
        end
    end
end