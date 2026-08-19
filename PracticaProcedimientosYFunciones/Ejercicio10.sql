DELIMITER //

CREATE PROCEDURE sp_categorizar_libros(IN p_anio YEAR)
BEGIN
	SELECT 
		titulo
        ,anio_publicacion
		,CASE
			WHEN anio_publicacion < 1900 THEN "Clasico"
            WHEN anio_publicacion <= p_anio THEN "Moderno"
            ELSE "Contemporaneo"
		END AS "Categoria"
	FROM libros;
END //

DELIMITER ;

CALL sp_categorizar_libros(1970);