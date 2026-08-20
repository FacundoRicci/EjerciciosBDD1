DELIMITER //

CREATE FUNCTION fn_prestamos_activos_usuario(nombreUsuario VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN (SELECT COUNT(*) FROM prestamos WHERE nombreUsuario = nombre_usuario);
END //

DELIMITER ;

SELECT fn_prestamos_activos_usuario("Carlos Gómez");