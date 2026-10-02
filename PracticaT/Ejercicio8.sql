DROP PROCEDURE IF EXISTS sp_prestar_libro;

DELIMITER //

CREATE PROCEDURE sp_prestar_libro(IN p_id_libro INT, IN p_nombre_usuario VARCHAR(50))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- El libro debe existir
    IF NOT EXISTS (SELECT 1 FROM libros WHERE id = p_id_libro) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El libro no existe';
    END IF;

    -- El libro no debe estar prestado (préstamo sin devolución real)
    IF EXISTS (SELECT 1 FROM prestamos
               WHERE libro_id = p_id_libro AND fecha_devolucion_real IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El libro ya está prestado';
    END IF;

    INSERT INTO prestamos (libro_id, nombre_usuario, fecha_prestamo,
                           fecha_devolucion_prevista, fecha_devolucion_real)
    VALUES (p_id_libro, p_nombre_usuario, CURRENT_DATE(),
            DATE_ADD(CURRENT_DATE(), INTERVAL 14 DAY), NULL);

    COMMIT;

    SELECT * FROM prestamos;
END //

DELIMITER ;

CALL sp_prestar_libro(11, 'Facundo Ricci');