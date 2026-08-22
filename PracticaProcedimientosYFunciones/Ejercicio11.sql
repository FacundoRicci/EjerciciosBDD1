USE biblioteca;

DELIMITER //

CREATE PROCEDURE sp_autores_por_nacionalidad(IN nacionalidadIngresada VARCHAR(50))
BEGIN
	SELECT AUT.nombre AS "Autor"
		,LIB.titulo AS "Libro"
		,COUNT(*) AS "Cantidad Prestamos" 
    FROM libros LIB
		JOIN autores AUT ON AUT.id = LIB.autor_id
        LEFT JOIN prestamos PRE ON PRE.libro_id = LIB.id
	WHERE AUT.nacionalidad = nacionalidadIngresada
    GROUP BY LIB.id;
    
END //

DELIMITER ;

call sp_autores_por_nacionalidad("Chilena");
