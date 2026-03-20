function flowshop_busqueda_local()
    % Programa principal para resolver flowshop permutacional mediante búsqueda local
    % Devuelve la mejor solución encontrada y la secuencia que lo genera
    
    clc;
    fprintf('=== RESOLUCIÓN DE FLOWSHOP PERMUTACIONAL ===\n');
    fprintf('Método: Búsqueda Local - Primer Mejor\n\n');
    
    % Pedir inputs al usuario
    filename = input('Introduce el nombre del archivo de datos: ', 's');
    criterio = input('¿Usar Fmax o Fmed? (max/med): ', 's');
    max_iteraciones_sin_mejora = input('Máximo de iteraciones sin mejora: ');
    
    % Leer datos del problema
    [num_maquinas, num_ordenes, d_matrix] = leer_archivo(filename);
    
    fprintf('\n--- PARÁMETROS DEL PROBLEMA ---\n');
    fprintf('Número de máquinas: %d\n', num_maquinas);
    fprintf('Número de órdenes: %d\n', num_ordenes);
    fprintf('Criterio de optimización: %s\n', upper(criterio));
    fprintf('Máximo iteraciones sin mejora: %d\n\n', max_iteraciones_sin_mejora);
    
    % Ejecutar búsqueda local
    [mejor_secuencia, mejor_valor, historial_mejores, iteraciones, vecinos_evaluados] = ...
        busqueda_local_flowshop(d_matrix, criterio, max_iteraciones_sin_mejora);
    
    % Mostrar resultados
    mostrar_resultados(mejor_secuencia, mejor_valor, historial_mejores, ...
        d_matrix, criterio, iteraciones, vecinos_evaluados);
    
    % Visualizar progreso de la búsqueda
    visualizar_progreso(historial_mejores, criterio, iteraciones);
    
    % Mostrar diagrama de Gantt de la mejor solución
    F_mejor = funcion_F(mejor_secuencia, d_matrix);
    visualizar_gantt_mejor(F_mejor, mejor_secuencia, d_matrix, mejor_valor);
end