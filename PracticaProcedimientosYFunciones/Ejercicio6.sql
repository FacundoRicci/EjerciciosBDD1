USE biblioteca;

DELIMITER //

CREATE PROCEDURE sp_libros_disponibles_por_genero(IN genero_a_buscar VARCHAR(50))
BEGIN
	SELECT 
		LIB.titulo AS "Titulo",
        AUT.nombre AS "Autor",
        LIB.anio_publicacion AS "Año Publicacion"
	FROM libros LIB
		JOIN autores AUT ON LIB.autor_id = AUT.id
    WHERE LIB.genero = genero_a_buscar;
END //

CALL sp_libros_disponibles_por_genero("Fantasía")