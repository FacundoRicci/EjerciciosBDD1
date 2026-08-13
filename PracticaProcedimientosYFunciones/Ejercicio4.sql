DELIMITER //

CREATE FUNCTION fn_contar_libros_autor(idAutor INT)
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN (SELECT COUNT(*) FROM libros WHERE autor_id = idAutor);
END //

SELECT fn_contar_libros_autor(2)