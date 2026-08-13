USE biblioteca;

DELIMITER //
/*
CREATE FUNCTION fn_obtener_genero (idLibro INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	IF (SELECT genero FROM libros WHERE id = idLibro) IS NOT NULL THEN
		RETURN (SELECT genero FROM libros WHERE id = idLibro);
	ELSE
		RETURN "Desconocido";	
	END IF;
END //
*/
SELECT fn_obtener_genero(null)