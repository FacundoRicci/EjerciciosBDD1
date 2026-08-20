DELIMITER //

CREATE FUNCTION fn_calcular_demanda_genero(generoRecibido VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE total_prestamos INT;
    DECLARE prestamos_genero INT; 
    DECLARE	porcentaje DECIMAL(5,2);
    DECLARE	indicador INT;
    
    SELECT COUNT(*) 
		INTO total_prestamos
		FROM prestamos;
    
    SELECT COUNT(*) 
		INTO prestamos_genero
		FROM libros LIB
			JOIN prestamos PRE ON LIB.id = PRE.id
        WHERE genero = generoRecibido;
        
	IF (total_prestamos = 0) THEN
		SET indicador = 0;
		RETURN indicador;
    ELSE 
		SET porcentaje = ROUND((prestamos_genero * 100) / total_prestamos, 2);
		IF (porcentaje <= 10) THEN
			SET indicador = 1;
		ELSEIF (porcentaje <= 20) THEN
			SET indicador = 2;
		ELSEIF (porcentaje <= 30) THEN
			SET indicador = 3;
		ELSEIF (porcentaje <= 40) THEN
			SET indicador = 4;
		ELSE
			SET indicador = 5;	
		END IF;
		RETURN indicador;
    END IF;
END //


DELIMITER ;
SELECT * from libros;
SELECT fn_calcular_demanda_genero("Realismo mágico");