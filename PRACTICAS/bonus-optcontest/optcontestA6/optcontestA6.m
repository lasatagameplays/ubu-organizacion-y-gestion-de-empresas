function [Fmed, tiempo_ejecucion, secuencia_optima] = optcontestA6(nombreDelArchivo)
    % OPTIMIZATION CONTEST - Organización y Gestión de Empresas
    % Universidad de Burgos
    % Equipo: A6 - "Los Trifuerza"
    % Integrante: Rubén Castañeda Matute
    %
    % Devolvemos lo siguiente: [Fmed, tiempo_ejecucion, secuencia_optima]
    
    % Aquí inicializamos la medición de tiempo
    t_inicio_global = tic;

    fprintf('=== OPTIMIZATION CONTEST - EQUIPO A6 ===\n');
    fprintf('Equipo: Los Trifuerza\n');
    fprintf('Integrante: Rubén Castañeda Matute\n\n');
    
    % Aquí detectamos si hay argumentos pasados al ejecutar la funcion optcontestA6
    if nargin < 1
        % Si no hay argumentos automaticamente el archivo a ejecutar sera
        % el default: "test.txt"
        filename = 'test.txt'; 
        fprintf('Modo automático detectado. Usaremos el archivo por defecto: %s\n', filename);
    else
        % En caso de que haya un argumento o mas pasados al ejecutar la
        % función optcontestA6, lo pondremos como archivo
        filename = nombreDelArchivo;

        % Aquí verificamos que el archivo exista
        if ~exist(filename, 'file')
            fprintf('Archivo no encontrado: %s', filename);
            filename = 'test.txt';
            fprintf('Pasando al modo automático. Usaremos el archivo por defecto: %s\n', filename);
        end
    end
    
    % Aquí verificamos que el archivo exista
    if ~exist(filename, 'file')
        error('Archivo no encontrado: %s', filename);
    end

    % Aquí obtenemos la fecha y hora actual
    fecha_inicio = datetime('now', 'Format', 'dd/MM/yyyy HH:mm:ss');
    fprintf('Fecha y hora de inicio: %s\n\n',char(fecha_inicio));
    
    % Aquí leeremos los datos del problema
    [num_ordenes, num_maquinas, d_matrix] = leer_datos_simple(filename);
    
    fprintf('\nProblema: %d órdenes × %d máquinas\n', num_ordenes, num_maquinas);
    fprintf('Algoritmo: Híbrido optimizado\n');
    fprintf('Tiempo máximo: 60 segundos\n\n');
    
    % Aquí ejecutamos el algoritmo con el tiempo de ejecución (58 segundos + 2 segundos de margen)
    [secuencia_optima, Fmed] = algoritmo_principal(d_matrix, 58);
    
    % Aquí obtenemos el tiempo de ejecución real
    tiempo_ejecucion = toc(t_inicio_global);

    % Aquí obtenemos la fecha y hora actual
    fecha_final = datetime('now', 'Format', 'dd/MM/yyyy HH:mm:ss');
    fprintf('\n\nFecha y hora al acabar la ejecución: %s\n',char(fecha_final));
    fprintf('Diferencia de fecha y hora al iniciar con la acabada: %s\n\n',char(fecha_final-fecha_inicio));
    
    % Aquí mostramos los resultados finales por pantalla
    mostrar_resultados_pantalla(Fmed, tiempo_ejecucion, secuencia_optima, filename);

    % Aquí guardaremos los resultados en un archivo
    guardar_resultados_archivo(Fmed, tiempo_ejecucion, secuencia_optima, filename, fecha_inicio, fecha_final);
end

function [num_ordenes, num_maquinas, d_matrix] = leer_datos_simple(filename)
    % Función que lee un archivo de datos
    
    fprintf('Leyendo el archivo: %s\n', filename);
    
    % Aquí cargamos todos los números
    try
        todos_numeros = load(filename);
    catch
        fid = fopen(filename, 'r');
        if fid == -1
            error('No se puede abrir el archivo: %s', filename);
        end
        contenido = textscan(fid, '%d');
        fclose(fid);
        todos_numeros = contenido{1};
    end
    
    % Aquí verificamos que la longitud no sea menor a 2
    if length(todos_numeros) < 2
        error('El archivo es muy corto');
    end
    
    % Aquí obtenemos el orden y las maquinas
    num_ordenes = todos_numeros(1);
    num_maquinas = todos_numeros(2);
    
    fprintf('  Órdenes: %d, Máquinas: %d\n', num_ordenes, num_maquinas);
    
    % Aquí extraemos los datos
    if length(todos_numeros) > 2
        datos = todos_numeros(3:end);
    else
        datos = [];
    end
    
    % Aquí verificamos la cantidad de datos
    esperados = num_ordenes * num_maquinas;
    
    if isempty(datos)
        error('El archivo no contiene datos de tiempos');
    elseif length(datos) < esperados
        % Aquí rellenamos con ceros
        datos = [datos; zeros(esperados - length(datos), 1)];
    elseif length(datos) > esperados
        % Aquí tomamos solo los necesarios
        datos = datos(1:esperados);
    end
    
    % Aquí creamos la matriz (órdenes × máquinas)
    d_matrix = reshape(datos, num_maquinas, num_ordenes)';
    
    fprintf('  Matriz: %d × %d\n', size(d_matrix, 1), size(d_matrix, 2));
end

function [mejor_secuencia, mejor_Fmed] = algoritmo_principal(d_matrix, tiempo_maximo)
    % Función que ejecuta el algoritmo híbrido optimizado
    % Esta función combina: Búsqueda aleatoria + Recocido Simulado + Búsqueda Local + GRASP
    
    tic;
    
    fprintf('Fase 1: Inicialización (5s)...\n');
    tiempo_fase1 = min(5, tiempo_maximo * 0.1);
    [mejor_secuencia, mejor_Fmed] = fase_inicializacion(d_matrix, tiempo_fase1);
    
    fprintf('\nMejor Fmed encontrado en la fase 1: %.2f\n', mejor_Fmed);

    fprintf('\nFase 2: Recocido Simulado...\n');
    tiempo_fase2 = tiempo_maximo * 0.7;
    [mejor_secuencia, mejor_Fmed] = fase_recocido(mejor_secuencia, d_matrix, tiempo_fase2);
    
    fprintf('\nMejor Fmed encontrado en la fase 2: %.2f\n', mejor_Fmed);

    fprintf('\nFase 3: Búsqueda Local...\n');
    tiempo_fase3 = tiempo_maximo * 0.2;
    [mejor_secuencia, mejor_Fmed] = fase_busqueda_local(mejor_secuencia, d_matrix, tiempo_fase3);
    
    fprintf('\nMejor Fmed encontrado en la fase 3: %.2f\n', mejor_Fmed);
end

function [mejor_secuencia, mejor_Fmed] = fase_inicializacion(d_matrix, tiempo_maximo)
    % Función que ejecuta la fase de inicialización
    
    tic;
    n = size(d_matrix, 1);
    mejor_Fmed = inf;
    
    while toc < tiempo_maximo
        % Aquí generamos diferentes tipos de inicialización entre 4
        % opciones que mas adelante veras
        tipo = randi(4);
        
        switch tipo
            case 1  % Aquí generamos una secuencia aleatoriamente
                secuencia = randperm(n);
                
            case 2  % Aquí generamos una secuencia con el metodo SPT (Shortest Processing Time)
                tiempos = sum(d_matrix, 2);
                [~, secuencia] = sort(tiempos);
                
            case 3  % Aquí generamos una secuencia con el metodo LPT (Longest Processing Time)
                tiempos = sum(d_matrix, 2);
                [~, secuencia] = sort(tiempos, 'descend');
                
            case 4  % Aquí generamos una secuencia con mezcla de todos los anteriores
                secuencia = randperm(n);
                % Aquí aplicamos el metodo SPT localmente
                for k = 1:floor(n/4)
                    i = randi(n-1);
                    if sum(d_matrix(secuencia(i), :)) > sum(d_matrix(secuencia(i+1), :))
                        secuencia([i, i+1]) = secuencia([i+1, i]);
                    end
                end
        end
        
        Fmed_actual = calcular_Fmed_simple(secuencia, d_matrix);
        
        if Fmed_actual < mejor_Fmed
            mejor_Fmed = Fmed_actual;
            mejor_secuencia = secuencia;
        end
    end
    
    fprintf('  Inicial: Fmed = %.2f\n', mejor_Fmed);
end

function [mejor_secuencia, mejor_Fmed] = fase_recocido(secuencia, d_matrix, tiempo_maximo)
    % Función que ejecuta la fase de recocido simulado con enfriamiento adaptativo
    
    % Aquí definimos los parámetros adaptativos
    tic;
    n = length(secuencia);
    T = 500;  % Aquí es la temperatura inicial

    % Aquí inicializamos el algoritmo recocido simulado
    Fmed_actual = calcular_Fmed_simple(secuencia, d_matrix);
    mejor_secuencia = secuencia;
    mejor_Fmed = Fmed_actual;
    
    iter = 0;
    while toc < tiempo_maximo
        for i = 1:max(20, round(30 * T/500))
            % Aquí generamos un vecino para el intercambio
            j = randi(n);
            k = randi(n);
            while j == k
                k = randi(n);
            end
            
            vecino = secuencia;
            vecino([j, k]) = vecino([k, j]);
            Fmed_vecino = calcular_Fmed_simple(vecino, d_matrix);
            
            delta = Fmed_vecino - Fmed_actual;
            
            if delta < 0 || rand() < exp(-delta/T)
                secuencia = vecino;
                Fmed_actual = Fmed_vecino;
                
                if Fmed_actual < mejor_Fmed
                    mejor_secuencia = secuencia;
                    mejor_Fmed = Fmed_actual;
                end
            end
            
            iter = iter + 1;
        end
        
        T = T * 0.95;

        if T <= 0.1
            T = 500; 
        end
    end
    
    fprintf('  Recocido: %d iter, Fmed = %.2f\n', iter, mejor_Fmed);
end

function [mejor_secuencia, mejor_Fmed] = fase_busqueda_local(secuencia, d_matrix, tiempo_maximo)
    % Función que gestiona la búsqueda local
    
    tic;
    Fmed_actual = calcular_Fmed_simple(secuencia, d_matrix);
    mejor_secuencia = secuencia;
    mejor_Fmed = Fmed_actual;
    
    n = length(secuencia);
    sin_mejora = 0;
    
    while toc < tiempo_maximo && sin_mejora < 5
        hubo_mejora = false;
        
        for i = 1:min(30, n-1)
            for j = i+1:min(31, n)
                vecino = secuencia;
                vecino([i, j]) = vecino([j, i]);
                Fmed_vecino = calcular_Fmed_simple(vecino, d_matrix);
                
                if Fmed_vecino < Fmed_actual
                    secuencia = vecino;
                    Fmed_actual = Fmed_vecino;
                    hubo_mejora = true;
                    
                    if Fmed_actual < mejor_Fmed
                        mejor_secuencia = secuencia;
                        mejor_Fmed = Fmed_actual;
                        sin_mejora = 0;
                    end
                    break;
                end
            end
            if hubo_mejora
                break;
            end
        end
        
        if ~hubo_mejora
            sin_mejora = sin_mejora + 1;
        end
    end
    
    fprintf('  Búsqueda Local: Fmed = %.2f\n', mejor_Fmed);
end

function Fmed = calcular_Fmed_simple(secuencia, d_matrix)
    % Función que calcula el Fmed (El cual es el tiempo promedio de flujo) para una secuencia
    
    % Aquí obtenemos las dimensiones
    [num_ordenes, num_maquinas] = size(d_matrix);

    % Aquí calculamos la matriz F de tiempos de salida
    F = zeros(num_maquinas, num_ordenes);
    
    % Aqui ejecutamos el programa en la primera máquina
    F(1, 1) = d_matrix(secuencia(1), 1);
    for j = 2:num_ordenes
        F(1, j) = F(1, j-1) + d_matrix(secuencia(j), 1);
    end
    
    % Aqui ejecutamos el programa en el resto de máquinas
    for i = 2:num_maquinas
        F(i, 1) = F(i-1, 1) + d_matrix(secuencia(1), i);
        for j = 2:num_ordenes
            if F(i-1, j) > F(i, j-1)
                F(i, j) = F(i-1, j) + d_matrix(secuencia(j), i);
            else
                F(i, j) = F(i, j-1) + d_matrix(secuencia(j), i);
            end
        end
    end
    
    % Aquí ejecutamos el algoritmo Fmed el cual es el promedio de los tiempos de
    % finalización en la última máquina
    Fmed = mean(F(end, :));
end

function mostrar_resultados_pantalla(Fmed, tiempo, secuencia, archivo_entrada)
    % Función que muestra los resultados por pantalla
    
    fprintf('\n=== RESULTADOS FINALES ===\n');
    fprintf('Archivo procesado: %s\n', archivo_entrada);
    fprintf('Fmed: %.2f\n', Fmed);
    fprintf('Tiempo de ejecución: %.2f segundos\n', tiempo);
    
    if tiempo > 60
        fprintf('¡ADVERTENCIA! Excede el tiempo límite del concurso (60s)\n');
        fprintf('Penalización: 5%% por cada 10 segundos extra\n');
        tiempoExcedido = tiempo - 60;
        redondeo = round(tiempoExcedido/10);
        penalizacion = redondeo * 5;
        fprintf('\n\nPenalización total a descontar: %d%% por exceder el tiempo \n(%d-60=%d segundos excedidos , %d/10=%d cantidad de penalizaciones (redondeo) , %d*5=%d%% de penalización)\n\n',penalizacion,tiempo,tiempoExcedido,tiempoExcedido,redondeo,redondeo,penalizacion);
    else
        fprintf('Dentro del límite de tiempo (60s)\n');
    end
    
    fprintf('\nSecuencia óptima (%d elementos):\n', length(secuencia));
    
    % Aquí mostramos los resultados en formato compacto
    if length(secuencia) <= 50
        for i = 1:length(secuencia)
            fprintf('%d ', secuencia(i));
            if mod(i, 20) == 0 && i < length(secuencia)
                fprintf('\n');
            end
        end
        fprintf('\n');
    else
        fprintf('Primeros 30 elementos:\n');
        for i = 1:30
            fprintf('%d ', secuencia(i));
            if mod(i, 10) == 0
                fprintf('\n');
            end
        end
        fprintf('\n...\n');
        fprintf('Últimos 30 elementos:\n');
        for i = length(secuencia)-29:length(secuencia)
            fprintf('%d ', secuencia(i));
            if mod(i - (length(secuencia)-29) + 1, 10) == 0
                fprintf('\n');
            end
        end
        fprintf('\n');
    end
    
    fprintf('\nPara el concurso, entrego estos 3 valores en este orden:\n');
    fprintf('1. Fmed: %.2f\n', Fmed);
    fprintf('2. Tiempo: %.2f\n', tiempo);
    fprintf('3. Secuencia: %d ', secuencia(1));
    if length(secuencia) > 1
        fprintf('%d ', secuencia(2:end));
    end
    fprintf('\n');
end

function guardar_resultados_archivo(Fmed, tiempo, secuencia, archivo_entrada, fecha_inicioP, fecha_finalP)
    % Función que sirve para guardar resultados en un archivo de texto
    
    % Aquí obtenemos la fecha y hora actual
    fecha_actual = datetime('now', 'Format', 'yyyyMMdd_HHmmss');
    fecha_formateada = datetime('now', 'Format', 'dd/MM/yyyy HH:mm:ss');
    
    % Aquí creamos el nombre del archivo de resultados
    [~, nombre_base, ~] = fileparts(archivo_entrada);
    timestamp_str = char(fecha_actual);
    archivo_salida = sprintf('resultados_%s_%s.txt', nombre_base, timestamp_str);
    
    % Aquí intentamos abrir el archivo para escribir
    fid = fopen(archivo_salida, 'w');
    if fid == -1
        fprintf('Error: No se pudo crear el archivo %s\n', archivo_salida);
        return;
    end
    
    % Aquí escribimos la cabecera del archivo
    fprintf(fid, '========================================\n');
    fprintf(fid, 'OPTIMIZATION CONTEST - RESULTADOS\n');
    fprintf(fid, 'Equipo: A6 - "Los Trifuerza"\n');
    fprintf(fid, 'Integrante: Rubén Castañeda Matute\n');
    fprintf(fid, 'Fecha: %s\n', char(fecha_formateada));
    fprintf(fid, 'Archivo de entrada: %s\n', archivo_entrada);
    fprintf(fid, '========================================\n\n');
    
    % Aquí escribimos los resultados
    fprintf(fid, 'RESULTADOS DETALLADOS:\n');
    fprintf(fid, '----------------------\n');
    fprintf(fid, 'Fecha y hora al iniciar la ejecución: %s\n',char(fecha_inicioP));
    fprintf(fid, 'Fecha y hora al acabar la ejecución: %s\n',char(fecha_finalP));
    fprintf(fid, 'Diferencia de fecha y hora al iniciar con la acabada: %s\n\n',char(fecha_finalP-fecha_inicioP));
    fprintf(fid, 'Fmed (tiempo promedio de flujo): %.2f\n', Fmed);
    fprintf(fid, 'Tiempo de ejecución: %.2f segundos\n', tiempo);
    
    if tiempo > 60
        fprintf(fid, 'ESTADO: EXCEDE TIEMPO LÍMITE (60s)\n');
        tiempoExcedido = tiempo - 60;
        redondeo = round(tiempoExcedido/10);
        penalizacion = redondeo * 5;
        fprintf(fid,'\n\nPenalización total a descontar: %d%% por exceder el tiempo \n(%d-60=%d segundos excedidos , %d/10=%d cantidad de penalizaciones (redondeo) , %d*5=%d%% de penalización)\n\n',penalizacion,tiempo,tiempoExcedido,tiempoExcedido,redondeo,redondeo,penalizacion);
    else
        fprintf(fid, 'ESTADO: DENTRO DEL LÍMITE DE TIEMPO\n');
        fprintf(fid, 'Margen de seguridad: %.2f segundos\n', 60 - tiempo);
    end
    
    % Aquí escribimos la secuencia
    fprintf(fid, '\nSECUENCIA ÓPTIMA:\n');
    fprintf(fid, '-----------------\n');
    fprintf(fid, 'Número de elementos: %d\n', length(secuencia));
    fprintf(fid, '\nSecuencia completa:\n');
    
    for i = 1:length(secuencia)
        fprintf(fid, '%d ', secuencia(i));
        if mod(i, 20) == 0 && i < length(secuencia)
            fprintf(fid, '\n');
        end
    end
    fprintf(fid, '\n');
    
    % Aquí escribimos la información adicional
    fprintf(fid, '\n========================================\n');
    fprintf(fid, 'PARA EL CONCURSO ENTREGO LO SIGUIENTE:\n');
    fprintf(fid, '========================================\n');
    fprintf(fid, 'Fmed: %.2f\n', Fmed);
    fprintf(fid, 'Tiempo: %.2f\n', tiempo);
    fprintf(fid, 'Secuencia:');
    for i = 1:length(secuencia)
        fprintf(fid, '%d ', secuencia(i));
    end
    fprintf(fid, '\n');
    
    % Aquí escribimos la información del algoritmo
    fprintf(fid, '\n========================================\n');
    fprintf(fid, 'INFORMACIÓN DEL ALGORITMO:\n');
    fprintf(fid, '========================================\n');
    fprintf(fid, 'Estrategia: Algoritmo híbrido\n');
    fprintf(fid, '\nFases:\n');
    fprintf(fid, '  1. Inicialización múltiple (aleatoria, SPT, LPT)\n');
    fprintf(fid, '  2. Recocido Simulado con enfriamiento geométrico\n');
    fprintf(fid, '  3. Búsqueda Local intensiva\n');
    fprintf(fid, '\nParámetros:\n');
    fprintf(fid, '  - Temperatura inicial: 500\n');
    fprintf(fid, '  - Temperatura final: 0.1\n');
    fprintf(fid, '  - Factor enfriamiento: 0.95\n');
    fprintf(fid, '  - Tiempo máximo: 58s (2s margen)\n');
    
    % Aquí escribimos las estadísticas adicionales
    fprintf(fid, '\n========================================\n');
    fprintf(fid, 'ESTADÍSTICAS ADICIONALES:\n');
    fprintf(fid, '========================================\n');
    fprintf(fid, 'Hora de inicio: %s\n', char(fecha_formateada));
    fprintf(fid, 'Tamaño del problema: %d órdenes\n', length(secuencia));
    fprintf(fid, 'Archivo de resultados: %s\n', archivo_salida);
    
    % Aquí cerramos el archivo
    fclose(fid);
    
    fprintf('\nResultados guardados en: %s\n', archivo_salida);
    fprintf('\nEl archivo contiene:\n');
    fprintf('  1. Resultados detallados\n');
    fprintf('  2. Valores para el concurso\n');
    fprintf('  3. Información del algoritmo utilizado\n');
    fprintf('  4. Estadísticas adicionales\n');
    
    % Aquí mostramos la información del archivo
    info_archivo = dir(archivo_salida);
    if ~isempty(info_archivo)
        fprintf('\n\nTamaño del archivo: %.2f KB\n', info_archivo.bytes / 1024);
        fprintf('Fecha de creación: %s\n\n', char(datetime(info_archivo.datenum, 'ConvertFrom', 'datenum', 'Format', 'dd/MM/yyyy HH:mm:ss')));
    end
end