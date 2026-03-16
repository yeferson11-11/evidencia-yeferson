CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;

-- =====================
-- TABLA AUTOR
-- =====================

CREATE TABLE tbl_autor (
aut_codigo INT PRIMARY KEY,
aut_apellido VARCHAR(45),
aut_nacimiento DATE,
aut_muerte DATE
);

INSERT INTO tbl_autor VALUES
(98,'Smith','1974-12-21','2018-07-21'),
(123,'Taylor','1980-04-15',NULL),
(234,'Medina','1977-06-21','2005-09-12'),
(345,'Wilson','1975-08-29',NULL),
(432,'Miller','1981-10-26',NULL),
(456,'García','1978-09-27','2021-12-09'),
(567,'Davis','1983-03-04','2010-03-28'),
(678,'Silva','1986-02-02',NULL),
(765,'López','1976-07-08',NULL),
(789,'Rodríguez','1985-12-10',NULL),
(890,'Brown','1982-11-17',NULL),
(901,'Soto','1979-05-13','2015-11-05');

-- =====================
-- TABLA LIBROS
-- =====================

CREATE TABLE tbl_libro (
lib_isbn BIGINT PRIMARY KEY,
lib_titulo VARCHAR(255),
lib_genero VARCHAR(20),
lib_numeroPaginas INT,
lib_diasPrestamo TINYINT
);

INSERT INTO tbl_libro VALUES
(1111111111,'Libro de prueba','novela',200,7),
(1234567890,'El Sueño de los Susurros','novela',275,7),
(1357924680,'El Jardín de las Mariposas Perdidas','novela',536,7),
(2468135790,'La Melodía de la Oscuridad','romance',189,3),
(2718281828,'El Bosque de los Suspiros','novela',397,2),
(3141592653,'El Secreto de las Estrellas Olvidadas','misterio',203,7),
(5555555555,'La Última Llave del Destino','cuento',503,3),
(8642097531,'El Reloj de Arena Infinito','novela',321,7),
(8888888888,'La Ciudad de los Susurros','misterio',274,1),
(9517530862,'Las Crónicas del Eco Silencioso','fantasía',448,7),
(9876543210,'El Laberinto de los Recuerdos','cuento',412,7),
(9999999999,'El Enigma de los Espejos Rotos','romance',156,3);

-- =====================
-- TABLA SOCIOS
-- =====================

CREATE TABLE tbl_socio (
soc_numero INT PRIMARY KEY,
soc_nombre VARCHAR(45),
soc_apellido VARCHAR(45),
soc_direccion VARCHAR(255),
soc_telefono VARCHAR(10)
);

INSERT INTO tbl_socio VALUES
(1,'Ana','Ruiz','Nueva Dir 123','3001112233'),
(2,'Andrés','Galindo','Avenida del Sol','3002223344'),
(3,'Juan','González','Calle Principal','301234567'),
(4,'María','Rodríguez','Carrera del Río','3012345678'),
(5,'Pedro','Martínez','Calle del Bosque','1234567812'),
(6,'Ana','López','Avenida Central','6123456781'),
(7,'Carlos','Sánchez','Calle de la Luna','1123456781'),
(8,'Laura','Ramírez','Carrera del Mar','1312345678'),
(9,'Luis','Hernández','Avenida Montaña','6101234567'),
(10,'Andrea','García','Calle del Sol','111234567');

-- =====================
-- TABLA PRESTAMO
-- =====================

CREATE TABLE tbl_prestamo (
pres_id VARCHAR(20) PRIMARY KEY,
pres_fechaPrestamo DATE,
pres_fechaDevolucion DATE,
soc_copiaNumero INT,
lib_copiaISBN BIGINT,

FOREIGN KEY (soc_copiaNumero)
REFERENCES tbl_socio(soc_numero),

FOREIGN KEY (lib_copiaISBN)
REFERENCES tbl_libro(lib_isbn)
);

INSERT INTO tbl_prestamo VALUES
('PR001','2026-03-01','2026-03-08',1,1111111111),
('PR002','2026-03-02','2026-03-09',2,1234567890),
('PR003','2026-03-03','2026-03-10',3,1357924680),
('PR004','2026-03-04','2026-03-11',4,2468135790);

-- =====================
-- TABLA TIPO AUTORES
-- =====================

CREATE TABLE tbl_tipoautores (
copiaISBN BIGINT,
copiaAutor INT,
tipoAutor VARCHAR(20),

PRIMARY KEY(copiaISBN,copiaAutor),

FOREIGN KEY (copiaAutor)
REFERENCES tbl_autor(aut_codigo),

FOREIGN KEY (copiaISBN)
REFERENCES tbl_libro(lib_isbn)
);

INSERT INTO tbl_tipoautores VALUES
(1111111111,98,'Autor'),
(1234567890,123,'Autor'),
(1234567890,456,'Coautor'),
(2468135790,234,'Autor'),
(3141592653,901,'Autor'),
(8642097531,345,'Autor');

-- =====================
-- TABLAS AUDITORIA
-- =====================

CREATE TABLE audi_libro(
id_audi INT AUTO_INCREMENT PRIMARY KEY,
lib_codigo_audi BIGINT,
titulo_anterior VARCHAR(100),
titulo_nuevo VARCHAR(100),
audi_fecha DATETIME,
audi_usuario VARCHAR(50),
audi_accion VARCHAR(20)
);

CREATE TABLE audi_socio(
id_audi INT AUTO_INCREMENT PRIMARY KEY,
socNumero_audi INT,
socNombre_anterior VARCHAR(45),
socApellido_anterior VARCHAR(45),
socDireccion_anterior VARCHAR(255),
socTelefono_anterior VARCHAR(10),
socNombre_nuevo VARCHAR(45),
socApellido_nuevo VARCHAR(45),
socDireccion_nuevo VARCHAR(255),
socTelefono_nuevo VARCHAR(10),
audi_fechaModificacion DATETIME,
audi_usuario VARCHAR(50),
audi_accion VARCHAR(20)
);

CREATE TABLE audi_autor(
id_audi INT AUTO_INCREMENT PRIMARY KEY,
aut_codigo INT,
aut_apellido_anterior VARCHAR(45),
aut_apellido_nuevo VARCHAR(45),
aut_nacimiento_anterior DATE,
aut_nacimiento_nuevo DATE,
aut_muerte_anterior DATE,
aut_muerte_nuevo DATE,
audi_fecha DATETIME,
audi_usuario VARCHAR(50),
audi_accion VARCHAR(20)
);

-- =====================
-- VISTAS
-- =====================

CREATE VIEW vista_libros_autores AS
SELECT
l.lib_titulo,
a.aut_apellido,
t.tipoAutor
FROM tbl_libro l
JOIN tbl_tipoautores t ON l.lib_isbn = t.copiaISBN
JOIN tbl_autor a ON t.copiaAutor = a.aut_codigo;

CREATE VIEW vista_prestamos_socios AS
SELECT
s.soc_nombre,
s.soc_apellido,
l.lib_titulo,
p.pres_fechaPrestamo,
p.pres_fechaDevolucion
FROM tbl_prestamo p
JOIN tbl_socio s ON p.soc_copiaNumero = s.soc_numero
JOIN tbl_libro l ON p.lib_copiaISBN = l.lib_isbn;

-- =====================
-- TRIGGERS
-- =====================

DELIMITER $$

CREATE TRIGGER trg_update_libro
AFTER UPDATE ON tbl_libro
FOR EACH ROW
BEGIN
INSERT INTO audi_libro
(lib_codigo_audi,titulo_anterior,titulo_nuevo,audi_fecha,audi_usuario,audi_accion)
VALUES
(OLD.lib_isbn, OLD.lib_titulo, NEW.lib_titulo, NOW(), USER(), 'UPDATE');
END$$

CREATE TRIGGER trg_update_socio
AFTER UPDATE ON tbl_socio
FOR EACH ROW
BEGIN
INSERT INTO audi_socio
VALUES
(NULL,
OLD.soc_numero,
OLD.soc_nombre,
OLD.soc_apellido,
OLD.soc_direccion,
OLD.soc_telefono,
NEW.soc_nombre,
NEW.soc_apellido,
NEW.soc_direccion,
NEW.soc_telefono,
NOW(),
USER(),
'UPDATE');
END$$

CREATE TRIGGER trg_update_autor
AFTER UPDATE ON tbl_autor
FOR EACH ROW
BEGIN
INSERT INTO audi_autor
VALUES
(NULL,
OLD.aut_codigo,
OLD.aut_apellido,
NEW.aut_apellido,
OLD.aut_nacimiento,
NEW.aut_nacimiento,
OLD.aut_muerte,
NEW.aut_muerte,
NOW(),
USER(),
'UPDATE');
END$$

DELIMITER ;

-- =====================
-- PROCEDIMIENTOS
-- =====================

DELIMITER $$

CREATE PROCEDURE ver_libros()
BEGIN
SELECT * FROM tbl_libro;
END$$

CREATE PROCEDURE ver_socios()
BEGIN
SELECT * FROM tbl_socio;
END$$

CREATE PROCEDURE registrar_prestamo(
IN idPrestamo VARCHAR(20),
IN fechaPrestamo DATE,
IN fechaDevolucion DATE,
IN socio INT,
IN libro BIGINT
)
BEGIN
INSERT INTO tbl_prestamo
VALUES(idPrestamo,fechaPrestamo,fechaDevolucion,socio,libro);
END$$

DELIMITER ;

-- =====================
-- EVENTO
-- =====================

DELIMITER $$

CREATE EVENT eliminar_prestamos_vencidos
ON SCHEDULE EVERY 1 DAY
DO
DELETE FROM tbl_prestamo
WHERE pres_fechaDevolucion < CURDATE();

$$

DELIMITER ;

COMMIT;
