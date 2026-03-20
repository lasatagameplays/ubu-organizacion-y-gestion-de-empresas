function es_valida = verificar_permutacion(secuencia)
    % Verificar si una secuencia es una permutación válida
    
    n = length(secuencia);
    es_valida = all(sort(secuencia) == 1:n) && length(unique(secuencia)) == n;
    
    if ~es_valida
        fprintf('Permutación inválida detectada: ');
        fprintf('%d ', secuencia);
        fprintf('\n');
    end
end