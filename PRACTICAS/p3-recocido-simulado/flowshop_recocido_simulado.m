function flowshop_recocido_simulado()
    % Programa principal para resolver flowshop permutacional mediante Recocido Simulado
    % Devuelve la mejor solución encontrada y la secuencia que lo genera
    
    clc;
    fprintf('=== RESOLUCIÓN DE FLOWSHOP PERMUTACIONAL ===\n');
    fprintf('Método: Recocido Simulado\n\n');
    
    % Pedir inputs al usuario
    filename = input('Introduce el nombre del archivo de datos: ', 's');
    criterio = input('¿Usar Fmax o Fmed? (max/med): ', 's');
    temperatura_inicial = input('Temperatura inicial: ');
    temperatura_final = input('Temperatura final: ');
    iteraciones_por_temperatura = input('Iteraciones por temperatura: ');
    factor_enfriamiento = input('Factor de enfriamiento (0-1): ');
    
    % Leer datos del problema
    [num_maquinas, num_ordenes, d_matrix] = leer_archivo(filename);
    
    fprintf('\n--- PARÁMETROS DEL PROBLEMA ---\n');
    fprintf('Número de máquinas: %d\n', num_maquinas);
    fprintf('Número de órdenes: %d\n', num_ordenes);
    fprintf('Criterio de optimización: %s\n', upper(criterio));
    fprintf('Temperatura inicial: %.2f\n', temperatura_inicial);
    fprintf('Temperatura final: %.4f\n', temperatura_final);
    fprintf('Iteraciones por temperatura: %d\n', iteraciones_por_temperatura);
    fprintf('Factor de enfriamiento: %.2f\n\n', factor_enfriamiento);
    
    % Ejecutar recocido simulado
    [mejor_secuencia, mejor_valor, historial_mejores, historial_temperaturas, aceptaciones] = ...
        recocido_simulado_flowshop(d_matrix, criterio, temperatura_inicial, ...
        temperatura_final, iteraciones_por_temperatura, factor_enfriamiento);
    
    % Mostrar resultados
    mostrar_resultados(mejor_secuencia, mejor_valor, historial_mejores, ...
        d_matrix, criterio, historial_temperaturas, aceptaciones);
    
    % Visualizar progreso de la búsqueda
    visualizar_progreso(historial_mejores, historial_temperaturas, criterio);
    
    % Mostrar diagrama de Gantt de la mejor solución
    F_mejor = funcion_F(mejor_secuencia, d_matrix);
    visualizar_gantt_mejor(F_mejor, mejor_secuencia, d_matrix, mejor_valor);
end