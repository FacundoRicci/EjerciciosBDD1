USE biblioteca;

START TRANSACTION;

UPDATE libros 
	SET disponible = false,
	genero = "Literatura fantastica"
		WHERE id = 5; 


ROLLBACK;
SELECT * FROM libros;