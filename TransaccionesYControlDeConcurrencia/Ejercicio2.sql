USE biblioteca;
DELIMITER //

CREATE PROCEDURE prestar_libro(IN idLibro INT, IN nombre_usuario VARCHAR(100))
BEGIN
START TRANSACTION;
	IF (SELECT disponible FROM libros WHERE id = idLibro AND disponible = TRUE) THEN
		UPDATE libros SET disponible = FALSE WHERE id = idLibro AND disponible = TRUE;
        
        INSERT INTO prestamos(libro_id,nombre_usuario,fecha_prestamo,fecha_devolucion_prevista)
			VALUES(idLibro,nombre_usuario,CURRENT_DATE,DATE_ADD(current_date,INTERVAL 7 DAY));
        
        COMMIT;
        SELECT * FROM prestamos;
	ELSE
		ROLLBACK;
        SELECT "No se pudo registrar el prestamo" AS mensaje;
	END IF;
END //


CALL prestar_libro(6,"Facundo");
 