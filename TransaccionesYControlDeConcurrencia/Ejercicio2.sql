USE biblioteca;
DELIMITER //

CREATE PROCEDURE prestar_libro(IN idLibro INT)
BEGIN
START TRANSACTION;
	IF (SELECT disponible FROM libros WHERE id = idLibro) THEN
		UPDATE libros SET disponible = FALSE WHERE id = idLibro;
        
        INSERT INTO prestamos(libro_id,nombre_usuario,fecha_prestamo,fecha_devolucion_prevista)
			VALUES(idLibro,"Facundo Ricci",CURRENT_DATE,DATE_ADD(current_date,INTERVAL 7 DAY));
        
        COMMIT;
	ELSE
		ROLLBACK;
	END IF;
    SELECT * FROM prestamos;
END //


CALL prestar_libro(5)
 