function [nueva_poblacion, nuevo_fitness] = reemplazar(poblacion, fitness, hijos, fitness_hijos)
    % Reemplazo elitista (mantiene el mejor individuo)
    
    % Combinar población actual e hijos
    poblacion_combinada = [poblacion; hijos];
    fitness_combinado = [fitness; fitness_hijos];
    
    % Ordenar por fitness
    [fitness_ordenado, idx_orden] = sort(fitness_combinado);
    
    % Seleccionar los mejores
    tam_poblacion = size(poblacion, 1);
    nueva_poblacion = poblacion_combinada(idx_orden(1:tam_poblacion), :);
    nuevo_fitness = fitness_ordenado(1:tam_poblacion);
end