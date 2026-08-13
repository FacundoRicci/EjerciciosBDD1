USE sistema_gestion_ventas;
CREATE TABLE clientes(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE
    );
    
CREATE TABLE productos(
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    stock INT NOT NULL DEFAULT(0)
    );

CREATE TABLE pedidos(
	id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    fecha DATE NOT NULL,
    
    FOREIGN KEY(id_cliente)
    REFERENCES clientes(id_cliente)
    ON DELETE CASCADE,
    
    FOREIGN KEY(id_producto)
    REFERENCES productos(id_producto)
    ON DELETE CASCADE
    );

DELIMITER $$

CREATE TRIGGER validar_stock_pedido
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    
	DECLARE stock_actual INT;
	SELECT stock INTO stock_actual FROM productos
		WHERE id_producto = NEW.id_producto;
    
    IF stock_actual < NEW.cantidad THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay stock suficiente para realizar el pedido';
	END IF;
    
END $$

DELIMITER ;