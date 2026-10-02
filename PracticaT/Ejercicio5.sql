

START TRANSACTION;

	INSERT INTO prestamos (libro_id,nombre_usuario,fecha_prestamo,fecha_devolucion_prevista,fecha_devolucion_real) 
		VALUES(6,"Juan Martinez",current_date(),date_add(current_date(),interval 7 day),null);
        

SELECT * from prestamos;
ROLLBACK;
