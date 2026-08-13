DELIMITER //

/*
CREATE PROCEDURE sp_marcar_no_disponible(IN idLibro INT)
BEGIN
	UPDATE libros SET disponible = FALSE WHERE id = idLibro;
END //
*/

CALL sp_marcar_no_disponible(2);
select * from libros;