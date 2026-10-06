USE biblioteca;
START TRANSACTION;

UPDATE libros 
	SET disponible = TRUE 
	WHERE id = 1;

ROLLBACK;

SELECT * FROM libros WHERE id=1;
