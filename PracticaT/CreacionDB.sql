DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE biblioteca;
USE biblioteca;
CREATE TABLE autores (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
nacionalidad VARCHAR(50),
fecha_nacimiento DATE
) ENGINE = InnoDB;
CREATE TABLE libros (
id INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(200) NOT NULL,
autor_id INT NOT NULL,
genero VARCHAR(50),
anio_publicacion INT,
disponible BOOLEAN DEFAULT TRUE,
FOREIGN KEY (autor_id) REFERENCES autores(id)
) ENGINE = InnoDB;
CREATE TABLE prestamos (
id INT AUTO_INCREMENT PRIMARY KEY,
libro_id INT NOT NULL,
nombre_usuario VARCHAR(100) NOT NULL,
fecha_prestamo DATE NOT NULL,
fecha_devolucion_prevista DATE NOT NULL,
fecha_devolucion_real DATE,
FOREIGN KEY (libro_id) REFERENCES libros(id)
) ENGINE = InnoDB;
CREATE TABLE reservas (
id INT AUTO_INCREMENT PRIMARY KEY,
libro_id INT NOT NULL,
nombre_usuario VARCHAR(100) NOT NULL,
fecha_reserva DATE NOT NULL,
estado ENUM('activa', 'completada', 'cancelada')
DEFAULT 'activa',
FOREIGN KEY (libro_id) REFERENCES libros(id)
) ENGINE = InnoDB;
INSERT INTO autores
(nombre, nacionalidad, fecha_nacimiento)
VALUES
('Gabriel García Márquez', 'Colombiana', '1927-03-06'),
('J.K. Rowling', 'Británica', '1965-07-31'),
('Jorge Luis Borges', 'Argentina', '1899-08-24'),
('Isabel Allende', 'Chilena', '1942-08-02'),
('Haruki Murakami', 'Japonesa', '1949-01-12'),
('Julio Cortázar', 'Argentina', '1914-08-26'),
('Mario Vargas Llosa', 'Peruana', '1936-03-28'),
('Antoine de Saint-Exupéry', 'Francesa', '1900-06-29');
INSERT INTO libros
(titulo, autor_id, genero, anio_publicacion, disponible)
VALUES
('Cien años de soledad', 1, 'Realismo mágico', 1967, TRUE),
('Crónica de una muerte anunciada', 1, 'Novela', 1981, TRUE),
('Harry Potter y la piedra filosofal', 2, 'Fantasía', 1997, TRUE),
('Harry Potter y la cámara secreta', 2, 'Fantasía', 1998, FALSE),
('El Aleph', 3, 'Ficción', 1949, TRUE),
('Ficciones', 3, 'Ficción', 1944, TRUE),
('La casa de los espíritus', 4, 'Realismo mágico', 1982, TRUE),
('De amor y de sombra', 4, 'Drama', 1984, TRUE),
('Tokio Blues', 5, 'Novela', 1987, TRUE),
('Kafka en la orilla', 5, 'Novela', 2002, FALSE),
('Rayuela', 6, 'Novela', 1963, TRUE),
('La ciudad y los perros', 7, 'Novela', 1963, TRUE),
('El Principito', 8, 'Ficción', 1943, TRUE);
INSERT INTO prestamos
(libro_id, nombre_usuario, fecha_prestamo,
fecha_devolucion_prevista, fecha_devolucion_real)
VALUES
(1, 'Ana López', '2026-03-01', '2026-03-15', '2026-03-13'),
(3, 'Carlos Pérez', '2026-03-05', '2026-03-19', '2026-03-25'),
(5, 'Lucía Gómez', '2026-04-02', '2026-04-16', '2026-04-16'),
(7, 'Martín Díaz', '2026-04-10', '2026-04-24', '2026-05-02'),
(1, 'Sofía Torres', '2026-05-01', '2026-05-15', '2026-05-14'),
(11, 'Ana López', '2026-05-10', '2026-05-24', '2026-05-30'),
(4, 'Pedro Ruiz', '2026-08-12', '2026-08-26', NULL),
(10, 'María Fernández', '2026-08-15', '2026-08-29', NULL);
INSERT INTO reservas
(libro_id, nombre_usuario, fecha_reserva, estado)
VALUES
(4, 'Laura Sánchez', '2026-08-18', 'activa'),
(10, 'Diego Romero', '2026-08-19', 'activa'),
(3, 'Mónica Silva', '2026-07-15', 'completada');


