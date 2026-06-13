USE agencia_personal;

-- 1) Mostrar la estructura de la tabla Empresas. Seleccionar toda la información de la misma.

-- DESCRIBE empresas;

-- 2) Mostrar la estructura de la tabla Personas. Mostrar el apellido y nombre y la fecha de registro en la agencia.
-- 3) Guardar el siguiente query en un archivo de extensión .sql, para luego correrlo. 
-- Mostrar los títulos con el formato de columna: Código Descripción y Tipo ordenarlo alfabéticamente por descripción.
-- 4) Mostrar de la persona con DNI nro. 28675888. El nombre y apellido,
-- fecha de nacimiento, teléfono, y su dirección. Las cabeceras de las columnas serán:

SELECT nombre,apellido,fecha_nacimiento FROM personas WHERE dni=28675888;

