DELIMITER //

CREATE PROCEDURE actualizar_autor_y_generos(
    IN p_autor_id INT,
    IN p_nuevo_nombre VARCHAR(100),
    IN p_nueva_nacionalidad VARCHAR(50),
    IN p_nuevo_genero VARCHAR(50)
)
BEGIN
    DECLARE v_existe_autor INT DEFAULT 0;

    -- Manejo de excepciones SQL: ante cualquier error, deshace toda la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Ocurrió un fallo al actualizar los datos. Transacción cancelada.' AS mensaje;
    END;

    -- Iniciamos la transacción global
    START TRANSACTION;

    -- 1. Verificamos si el autor realmente existe en la base de datos
    SELECT COUNT(*) INTO v_existe_autor
    FROM autores
    WHERE id = p_autor_id;

    IF v_existe_autor = 0 THEN
        -- Si el autor no existe, cancelamos la transacción de inmediato
        ROLLBACK;
        SELECT 'Error: El autor especificado no existe.' AS mensaje;
    ELSE
        -- 2. Actualizamos los datos principales del autor
        UPDATE autores
        SET nombre = p_nuevo_nombre,
            nacionalidad = p_nueva_nacionalidad
        WHERE id = p_autor_id;

        -- 3. Actualizamos en masa el género de TODOS los libros vinculados a dicho autor
        UPDATE libros
        SET genero = p_nuevo_genero
        WHERE autor_id = p_autor_id;

        -- Confirmamos los cambios de ambas tablas de manera permanente
        COMMIT;
        SELECT 'Actualización masiva completada con éxito.' AS mensaje;
    END IF;

END //

DELIMITER ;