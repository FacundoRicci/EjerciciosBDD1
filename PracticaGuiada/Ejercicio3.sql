CREATE DATABASE gestion_hotel;
USE gestion_hotel;

CREATE TABLE Habitaciones(
	id_habitacion INT AUTO_INCREMENT PRIMARY KEY,
    tipo_habitacion VARCHAR(100) NOT NULL,
    precio_noche INT NOT NULL CHECK (precio_noche > 0),
    disponibilidad BOOLEAN NOT NULL
);

CREATE TABLE Clientes(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Reservas(
	id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_habitacion INT NOT NULL,
    fecha_check_in DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_check_out DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_habitacion) REFERENCES Habitaciones(id_habitacion) ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER validar_disponibilidad
BEFORE INSERT ON Reservas
FOR EACH ROW 
BEGIN
	DECLARE check_in DATETIME;
    DECLARE check_out DATETIME;
    SELECT fecha_check_in,fecha_check_out INTO check_in,check_out FROM Reservas 
		WHERE id_habitacio = NEW.id_Habitacion 
        ORDER BY fecha_check_out DESC
        LIMIT 1; 
    IF NEW.fecha_check_in BETWEEN check_in AND check_out OR NEW.fecha_check_out BETWEEN check_in AND check_out THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Esta habitacion no se encuentra disponible';
    END IF;
END $$
