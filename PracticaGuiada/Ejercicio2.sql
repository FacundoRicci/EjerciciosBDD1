USE biblioteca;

CREATE TABLE Clientes(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Libros(
	id_libro INT AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0),
	precio INT NOT NULL CHECK (precio > 0)
);

CREATE TABLE Prestamos(
	id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_libro INT NOT NULL,
    id_cliente INT NOT NULL,
    fecha_prestamo DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_devolucion DATETIME,
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro) ON DELETE CASCADE,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER validar_stock_libro
BEFORE INSERT ON Prestamos
FOR EACH ROW
BEGIN
	DECLARE stock_actual INT;
    SELECT stock INTO stock_actual FROM Libros 
		WHERE id_libro = NEW.id_libro;
	-- Si no hay suficiente stock lanzar un error
    IF stock > 0 THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay stock suficiente para realizar el pedido';
	END IF;
END $$

DELIMITER ;