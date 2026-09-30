DELIMITER //

CREATE PROCEDURE devolver_libro(IN p_prestamo_id INT)
BEGIN
    DECLARE v_libro_id INT;
    DECLARE v_ya_devuelto INT;
    
    -- Manejador de excepciones: si ocurre cualquier error SQL, deshace la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error crítico: La transacción se canceló por un fallo en la base de datos.' AS mensaje;
    END;

    START TRANSACTION;

    SELECT libro_id, IF(fecha_devolucion_real IS NOT NULL, 1, 0)
    INTO v_libro_id, v_ya_devuelto
    FROM prestamos
    WHERE id = p_prestamo_id;

    -- Validaciones
    IF v_libro_id IS NULL THEN
        ROLLBACK;
        SELECT 'Error: El número de préstamo especificado no existe.' AS mensaje;

    ELSEIF v_ya_devuelto = 1 THEN
        ROLLBACK;
        SELECT 'Aviso: Este libro ya fue devuelto anteriormente.' AS mensaje;

    ELSE
        UPDATE prestamos
        SET fecha_devolucion_real = CURRENT_DATE()
        WHERE id = p_prestamo_id;

        UPDATE libros
        SET disponible = TRUE
        WHERE id = v_libro_id;

        COMMIT;
        SELECT 'Devolución registrada con éxito. El libro vuelve a estar disponible.' AS mensaje;
    END IF;

END //

DELIMITER ;