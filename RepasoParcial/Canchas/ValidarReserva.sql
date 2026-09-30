DELIMITER //

CREATE FUNCTION fn_validar_reserva(
    p_id_cliente INT,
    p_id_cancha INT,
    p_fecha DATE,
    p_hora DATETIME
) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_estado_cancha VARCHAR(20);
    DECLARE v_reservas_cancha INT;
    DECLARE v_reservas_cliente_hora INT;
    DECLARE v_pendientes_cliente INT;

    -- 1. Verificar si la cancha existe y si está 'Disponible'
    SELECT estado INTO v_estado_cancha 
    FROM canchas 
    WHERE id_cancha = p_id_cancha;

    IF v_estado_cancha IS NULL THEN
        RETURN 1; -- La cancha no existe
    ELSEIF v_estado_cancha <> 'Disponible' THEN
        RETURN 2; -- La cancha está en Mantenimiento
    END IF;

    -- 2. Verificar disponibilidad de la cancha en esa fecha y hora
    SELECT COUNT(*) INTO v_reservas_cancha
    FROM reservas
    WHERE id_cancha = p_id_cancha 
      AND fecha = p_fecha 
      AND hora = p_hora 
      AND estado IN ('Pendiente', 'Confirmada');

    IF v_reservas_cancha > 0 THEN
        RETURN 3; -- La cancha ya tiene una reserva en ese horario
    END IF;

    -- 3. Verificar que el cliente no tenga otra reserva en la misma fecha y hora
    SELECT COUNT(*) INTO v_reservas_cliente_hora
    FROM reservas
    WHERE id_cliente = p_id_cliente 
      AND fecha = p_fecha 
      AND hora = p_hora 
      AND estado IN ('Pendiente', 'Confirmada');

    IF v_reservas_cliente_hora > 0 THEN
        RETURN 4; -- El cliente ya tiene otra reserva en ese horario
    END IF;

    -- 4. Verificar limite de máximo 3 reservas 'Pendiente' para el cliente
    SELECT COUNT(*) INTO v_pendientes_cliente
    FROM reservas
    WHERE id_cliente = p_id_cliente 
      AND estado = 'Pendiente';

    IF v_pendientes_cliente >= 3 THEN
        RETURN 5; -- El cliente alcanzó el máximo de 3 reservas pendientes
    END IF;

    RETURN 0; -- Todo OK
END //

DELIMITER ;