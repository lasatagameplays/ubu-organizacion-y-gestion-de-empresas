function [num_maquinas, num_ordenes, d_matrix] = leer_archivo(filename)
    % Leer archivo de datos del problema flowshop
    
    fid = fopen(filename, 'r');
    if fid == -1
        error('No se pudo abrir el archivo: %s', filename);
    end
    
    % Leer primera línea
    primera_linea = fgetl(fid);
    primeros_numeros = sscanf(primera_linea, '%d');
    num_ordenes = primeros_numeros(1);
    num_maquinas = primeros_numeros(2);
    
    fprintf('Leyendo: %d órdenes, %d máquinas\n', num_ordenes, num_maquinas);
    
    % Leer todas las líneas de datos
    todas_lineas = textscan(fid, '%d %d %d %d', num_ordenes);
    fclose(fid);
    
    % Crear matriz temporal
    temp_matrix = zeros(num_ordenes, 4);
    for i = 1:4
        temp_matrix(:, i) = todas_lineas{i};
    end
    
    % Construir la matriz d_matrix con órdenes en filas y máquinas en columnas
    d_matrix = zeros(num_ordenes, num_maquinas);
    
    for orden = 1:num_ordenes
        d_matrix(orden, 1) = temp_matrix(orden, 2);  % Tiempo en máquina 1
        d_matrix(orden, 2) = temp_matrix(orden, 4);  % Tiempo en máquina 2
    end
end