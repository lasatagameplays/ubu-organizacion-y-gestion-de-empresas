function [num_ordenes, num_maquinas, d_matrix] = leer_archivo_contest(filename)
    % Función que sirve para leer un archivo de datos optimizado para velocidad
    
    fid = fopen(filename, 'r');
    if fid == -1
        error('No se pudo abrir el archivo: %s', filename);
    end
    
    % Aquí leemos la primera línea
    primera_linea = fgetl(fid);
    if isempty(primera_linea)
        fclose(fid);
        error('El archivo %s está vacío', filename);
    end
    
    primeros_numeros = sscanf(primera_linea, '%d');
    
    if length(primeros_numeros) < 2
        fclose(fid);
        error('Formato de archivo incorrecto. La primera línea debe tener al menos 2 números.');
    end
    
    num_ordenes = primeros_numeros(1);
    num_maquinas = primeros_numeros(2);
    
    fprintf('Leyendo archivo: %s\n', filename);
    fprintf('  Órdenes: %d, Máquinas: %d\n', num_ordenes, num_maquinas);
    
    % Aquí leemos todo el resto del archivo de una vez (El cual es más eficiente)
    contenido = textscan(fid, '%d', 'Delimiter', '', 'WhiteSpace', '');
    fclose(fid);
    
    todos_numeros = contenido{1};
    
    % Aquí verificamos que tenemos suficientes datos
    datos_esperados = num_ordenes * num_maquinas * 2;
    if length(todos_numeros) < datos_esperados
        error('Archivo incompleto. Esperados %d números, encontrados %d', ...
            datos_esperados, length(todos_numeros));
    end
    
    % Aquí construimos la matriz d_matrix
    d_matrix = zeros(num_ordenes, num_maquinas);
    
    % Aquí definimos el formato siguiente: 0 tiempo1 1 tiempo2 ... para cada orden
    for i = 1:num_ordenes
        inicio_idx = (i-1) * (num_maquinas * 2);
        for j = 1:num_maquinas
            % Aquí definimos la posición del tiempo (Basicamente con números pares)
            idx_tiempo = inicio_idx + 2*j;
            if idx_tiempo <= length(todos_numeros)
                d_matrix(i, j) = todos_numeros(idx_tiempo);
            else
                error('Faltan datos para la orden %d, máquina %d', i, j);
            end
        end
    end
    
    fprintf('  Matriz de tiempos cargada correctamente (%d x %d)\n', ...
        size(d_matrix, 1), size(d_matrix, 2));
end