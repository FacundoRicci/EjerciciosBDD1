DELIMITER //

CREATE PROCEDURE sp_insertar_autor(IN nombreNuevo VARCHAR(50), nacionalidadNueva VARCHAR(50), fechaNacimientoNueva DATE)
BEGIN
	INSERT INTO autores(nombre,nacionalidad,fecha_nacimiento) VALUES(nombreNuevo,nacionalidadNueva,fechaNacimientoNueva);
END //

#CALL sp_insertar_autor("Juan","Rosario",CURRENT_DATE())

SELECT * from autores