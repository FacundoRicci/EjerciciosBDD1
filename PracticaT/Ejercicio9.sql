USE biblioteca;

DROP PROCEDURE IF EXISTS sp_devolver_libro;

DELIMITER //

CREATE PROCEDURE sp_devolver_libro(IN p_id_prestamo INT)
BEGIN
DECLARE v_id_libro INT;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    
    START TRANSACTION;
    
    
    IF NOT EXISTS(SELECT 1 FROM prestamos WHERE id = p_id_prestamo) THEN
		 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El prestamo no existe';
	END IF;
    
    IF (SELECT fecha_devolucion_real FROM prestamos WHERE id = p_id_prestamo) IS NOT NULL THEN
		 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El prestamo ya fue devuelto';
	END IF;
    
    UPDATE prestamos SET fecha_devolucion_real = current_date() WHERE id = p_id_prestamo;
	
    SELECT libro_id INTO v_id_libro FROM prestamos WHERE id = p_id_prestamo;
    
    UPDATE libros SET disponible = TRUE WHERE id = v_id_libro;
    
    COMMIT;
    
    SELECT * FROM prestamos;
END //

DELIMITER ;

CALL sp_devolver_libro(17)