DELIMITER //

CREATE PROCEDURE sp_registrar_reserva(
    IN p_id_cliente INT,
    IN p_id_cancha INT,
    IN p_fecha DATE,
    IN p_hora DATETIME
)
BEGIN
    DECLARE v_codigo_validacion INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error crítico: Ocurrió un fallo en la base de datos. Transacción cancelada.' AS resultado;
    END;

    -- Inicio de la Transacción
    START TRANSACTION;

    -- Evaluamos la función con las reglas de negocio
    SET v_codigo_validacion = fn_validar_reserva(p_id_cliente, p_id_cancha, p_fecha, p_hora);

    IF v_codigo_validacion = 0 THEN
        -- Registro de la reserva con los campos adaptados
        INSERT INTO reservas (id_cliente, id_cancha, fecha, hora, estado)
        VALUES (p_id_cliente, p_id_cancha, p_fecha, p_hora, 'Pendiente');

        COMMIT;
        SELECT 'ÉXITO: Reserva registrada correctamente.' AS resultado;
    ELSE
        -- Cancelamos la transacción ante cualquier incumplimiento
        ROLLBACK;
        
        CASE v_codigo_validacion
            WHEN 1 THEN SELECT 'ERROR: La cancha especificada no existe.' AS resultado;
            WHEN 2 THEN SELECT 'ERROR: La cancha se encuentra en Mantenimiento.' AS resultado;
            WHEN 3 THEN SELECT 'ERROR: La cancha ya está reservada para esa fecha y hora.' AS resultado;
            WHEN 4 THEN SELECT 'ERROR: El cliente ya posee otra reserva en esa fecha y hora.' AS resultado;
            WHEN 5 THEN SELECT 'ERROR: El cliente superó el límite de 3 reservas pendientes.' AS resultado;
        END CASE;
    END IF;

END //

DELIMITER ;