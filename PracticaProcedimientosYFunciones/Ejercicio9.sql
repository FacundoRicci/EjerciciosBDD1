USE biblioteca;

DELIMITER //

CREATE FUNCTION fn_promedio_libros_por_autor()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	RETURN (SELECT AVG(total_libros) FROM (SELECT COUNT(id) AS total_libros FROM libros GROUP BY autor_id) AS libros_por_autor);
END //


SELECT fn_promedio_libros_por_autor() AS Promedio;