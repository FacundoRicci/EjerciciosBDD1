DELIMITER //

CREATE FUNCTION fn_calcular_multa(idPrestamo INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE @Atraso AS INT;
    SET @Atraso = (SELECT (DATEDIFF(day, fecha_devolucion_prevista, fecha_devolucion_real)) FROM prestamos WHERE id = idPrestamo);
	IF @Atraso <= 0 THEN
		RETURN 0
 	ELSE IF @Atraso <= 10 THEN
		RETURN @Atraso * 500
	ELSE
		RETURN @Atraso * 1000
END //