DELIMITER //

CREATE PROCEDURE sp_actualizar_libro(IN idLibro INT, tituloNuevo VARCHAR(50), generoNuevo VARCHAR(50), anioPublicacionNuevo INT)
BEGIN
	UPDATE libros SET titulo = tituloNuevo, genero = generoNuevo, anio_publicacion = anioPublicacionNuevo WHERE id = idLibro;
END //


CALL sp_actualizar_libro(10,"El Rey Leon","Fantasía",2020);
SELECT * from libros;