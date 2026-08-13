USE afatse;

DELIMITER //

/*
CREATE PROCEDURE buscarAlumno(IN dniAlumno INT)
BEGIN
	SELECT * FROM alumnos WHERE dni = dniAlumno;
END //

CREATE PROCEDURE obtenerCantidadAlumnos(OUT cantidad INT)
BEGIN
	SELECT COUNT(*) into cantidad FROM alumnos;
END //
*/
DELIMITER ;

#CALL buscarAlumno(23232323)

CALL obtenerCantidadAlumnos(@cantidad);
SELECT @cantidad