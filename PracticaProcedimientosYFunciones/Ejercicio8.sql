DELIMITER //

CREATE PROCEDURE sp_registrar_libro(IN autor_buscado VARCHAR(50))
BEGIN
	IF (SELECT id FROM autores WHERE nombre = autor_buscado) != NULL THEN
		SELECT * FROM autores;
	ELSE 
		SELECT * FROM libros;
    END IF;
END //

CALL sp_registrar_libro("Juan");

SELECT * FROM autores