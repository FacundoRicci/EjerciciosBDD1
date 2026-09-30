USE canchas;

CREATE TABLE clientes(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    dni INT NOT NULL CHECK(dni>0) UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE canchas(
	id_cancha INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo_superficie VARCHAR(50) NOT NULL,
    precio INT NOT NULL CHECK(precio>0), 
    estado ENUM('Disponible','Mantenimiento') NOT NULL
);

CREATE TABLE reservas(
	id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_cancha INT NOT NULL,
    fecha DATE NOT NULL,
    hora DATETIME NOT NULL,
    estado ENUM('Pendiente','Confirmada','Cancelada') DEFAULT 'Pendiente' NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_cancha) REFERENCES canchas(id_cancha)
);