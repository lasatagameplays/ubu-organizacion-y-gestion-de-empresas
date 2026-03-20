function flowshop_algoritmo_genetico()
    % Programa principal para resolver flowshop permutacional mediante Algoritmo Genético
    % Devuelve la mejor solución encontrada y la secuencia que lo genera
    
    clc;
    fprintf('=== RESOLUCIÓN DE FLOWSHOP PERMUTACIONAL ===\n');
    fprintf('Método: Algoritmo Genético\n\n');
    
    % Pedir inputs al usuario
    filename = input('Introduce el nombre del archivo de datos: ', 's');
    criterio = input('¿Usar Fmax o Fmed? (max/med): ', 's');
    tamano_poblacion = input('Tamaño de la población: ');
    num_generaciones = input('Número de generaciones: ');
    prob_cruce = input('Probabilidad de cruce (0-1): ');
    prob_mutacion = input('Probabilidad de mutación (0-1): ');
    metodo_seleccion = input('Método de selección (ruleta/torneo): ', 's');
    
    % Leer datos del problema
    [num_maquinas, num_ordenes, d_matrix] = leer_archivo(filename);
    
    fprintf('\n--- PARÁMETROS DEL ALGORITMO GENÉTICO ---\n');
    fprintf('Número de máquinas: %d\n', num_maquinas);
    fprintf('Número de órdenes: %d\n', num_ordenes);
    fprintf('Criterio de optimización: %s\n', upper(criterio));
    fprintf('Tamaño de población: %d\n', tamano_poblacion);
    fprintf('Número de generaciones: %d\n', num_generaciones);
    fprintf('Probabilidad de cruce: %.2f\n', prob_cruce);
    fprintf('Probabilidad de mutación: %.2f\n', prob_mutacion);
    fprintf('Método de selección: %s\n\n', metodo_seleccion);
    
    % Ejecutar algoritmo genético
    [mejor_secuencia, mejor_valor, historial_mejores, historial_promedio, diversidad] = ...
        algoritmo_genetico_flowshop(d_matrix, criterio, tamano_poblacion, ...
        num_generaciones, prob_cruce, prob_mutacion, metodo_seleccion);
    
    % Mostrar resultados
    mostrar_resultados(mejor_secuencia, mejor_valor, historial_mejores, ...
        d_matrix, criterio, num_generaciones, tamano_poblacion);
    
    % Visualizar progreso del algoritmo
    visualizar_progreso(historial_mejores, historial_promedio, diversidad, criterio);
    
    % Mostrar diagrama de Gantt de la mejor solución
    F_mejor = funcion_F(mejor_secuencia, d_matrix);
    visualizar_gantt_mejor(F_mejor, mejor_secuencia, d_matrix, mejor_valor);
end