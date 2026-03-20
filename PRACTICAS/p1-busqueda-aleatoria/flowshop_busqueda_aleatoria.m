function flowshop_busqueda_aleatoria()
    % Programa principal para resolver flowshop permutacional mediante búsqueda aleatoria
    % Devuelve la mejor solución encontrada y la secuencia que lo genera
    
    clc;
    fprintf('=== RESOLUCIÓN DE FLOWSHOP PERMUTACIONAL ===\n');
    fprintf('Método: Búsqueda Aleatoria Simple\n\n');
    
    % Pedir inputs al usuario
    filename = input('Introduce el nombre del archivo de datos: ', 's');
    num_iteraciones = input('Introduce el número de iteraciones: ');
    criterio = input('¿Usar Fmax o Fmed? (max/med): ', 's');
    
    % Leer datos del problema
    [num_maquinas, num_ordenes, d_matrix] = leer_archivo(filename);
    
    fprintf('\n--- PARÁMETROS DEL PROBLEMA ---\n');
    fprintf('Número de máquinas: %d\n', num_maquinas);
    fprintf('Número de órdenes: %d\n', num_ordenes);
    fprintf('Número de iteraciones: %d\n', num_iteraciones);
    fprintf('Criterio de optimización: %s\n\n', upper(criterio));
    
    % Ejecutar búsqueda aleatoria
    [mejor_secuencia, mejor_valor, historial_mejores] = busqueda_aleatoria_flowshop(...
        d_matrix, num_iteraciones, criterio);
    
    % Mostrar resultados
    mostrar_resultados(mejor_secuencia, mejor_valor, historial_mejores, ...
        d_matrix, criterio, num_iteraciones);
    
    % Visualizar progreso de la búsqueda
    visualizar_progreso(historial_mejores, criterio, num_iteraciones);
    
    % Mostrar diagrama de Gantt de la mejor solución
    F_mejor = funcion_F(mejor_secuencia, d_matrix);
    visualizar_gantt_mejor(F_mejor, mejor_secuencia, d_matrix, mejor_valor);
end