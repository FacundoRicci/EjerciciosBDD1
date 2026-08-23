USE biblioteca; 
DELIMITER //

CREATE PROCEDURE  sp_generar_reporte_prestamos_autor(IN idAutorBuscado INT)
BEGIN
	SELECT 
		PRE.nombre_usuario AS "Nombre Socio"
        ,LIB.titulo AS "Libro"
        ,AUT.nombre AS "Autor"
    FROM prestamos PRE 
		JOIN libros LIB ON LIB.id = PRE.libro_id
		JOIN autores AUT ON  AUT.id = LIB.autor_id
	WHERE AUT.id = idAutorBuscado;

END //

CALL sp_generar_reporte_prestamos_autor(3);


DELIMITER ;