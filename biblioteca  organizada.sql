-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-04-2026 a las 17:38:37
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

DELIMITER $$
--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_TotalSocios` () RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE v_total INT;
    SELECT COUNT(*) INTO v_total FROM tbl_socio;
    RETURN v_total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_autor`
--

CREATE TABLE `audi_autor` (
  `id_audi` int(11) NOT NULL,
  `aut_codigo` int(11) DEFAULT NULL,
  `aut_apellido_anterior` varchar(45) DEFAULT NULL,
  `aut_apellido_nuevo` varchar(45) DEFAULT NULL,
  `aut_nacimiento_anterior` date DEFAULT NULL,
  `aut_nacimiento_nuevo` date DEFAULT NULL,
  `aut_muerte_anterior` date DEFAULT NULL,
  `aut_muerte_nuevo` date DEFAULT NULL,
  `audi_fecha` datetime DEFAULT NULL,
  `audi_usuario` varchar(50) DEFAULT NULL,
  `audi_accion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_libro`
--

CREATE TABLE `audi_libro` (
  `id_audi` int(11) NOT NULL,
  `lib_codigo_audi` bigint(20) DEFAULT NULL,
  `titulo_anterior` varchar(100) DEFAULT NULL,
  `titulo_nuevo` varchar(100) DEFAULT NULL,
  `audi_fecha` datetime DEFAULT NULL,
  `audi_usuario` varchar(50) DEFAULT NULL,
  `audi_accion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_socio`
--

CREATE TABLE `audi_socio` (
  `id_audi` int(11) NOT NULL,
  `socNumero_audi` int(11) DEFAULT NULL,
  `socNombre_anterior` varchar(45) DEFAULT NULL,
  `socApellido_anterior` varchar(45) DEFAULT NULL,
  `socDireccion_anterior` varchar(255) DEFAULT NULL,
  `socTelefono_anterior` varchar(10) DEFAULT NULL,
  `socNombre_nuevo` varchar(45) DEFAULT NULL,
  `socApellido_nuevo` varchar(45) DEFAULT NULL,
  `socDireccion_nuevo` varchar(255) DEFAULT NULL,
  `socTelefono_nuevo` varchar(10) DEFAULT NULL,
  `audi_fechaModificacion` datetime DEFAULT NULL,
  `audi_usuario` varchar(50) DEFAULT NULL,
  `audi_accion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_autor`
--

CREATE TABLE `tbl_autor` (
  `aut_codigo` int(11) NOT NULL,
  `aut_nombre` varchar(45) DEFAULT NULL,
  `aut_apellido` varchar(45) DEFAULT NULL,
  `aut_nacimiento` date DEFAULT NULL,
  `aut_muerte` date DEFAULT NULL,
  `aut_tipo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_autor`
--

INSERT INTO `tbl_autor` (`aut_codigo`, `aut_nombre`, `aut_apellido`, `aut_nacimiento`, `aut_muerte`, `aut_tipo`) VALUES
(98, NULL, 'Smith', '1974-12-21', '2018-07-21', NULL),
(123, NULL, 'Taylor', '1980-04-15', NULL, NULL),
(234, NULL, 'Medina', '1977-06-21', '2005-09-12', NULL),
(345, NULL, 'Wilson', '1975-08-29', NULL, NULL),
(432, NULL, 'Desconocido', '1990-01-01', NULL, NULL),
(456, NULL, 'García', '1978-09-27', '2021-12-09', NULL),
(567, NULL, 'Davis', '1983-03-04', '2010-03-28', NULL),
(678, NULL, 'Silva', '1986-02-02', NULL, NULL),
(765, NULL, 'López', '1976-07-08', NULL, NULL),
(789, NULL, 'Rodríguez', '1985-12-10', NULL, NULL),
(890, NULL, 'Brown', '1982-11-17', NULL, NULL),
(901, NULL, 'Soto', '1979-05-13', '2015-11-05', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_libro`
--

CREATE TABLE `tbl_libro` (
  `lib_isbn` bigint(20) NOT NULL,
  `lib_titulo` varchar(255) DEFAULT NULL,
  `lib_genero` varchar(20) DEFAULT NULL,
  `lib_editorial` varchar(45) DEFAULT NULL,
  `lib_numeroPaginas` int(11) DEFAULT NULL,
  `lib_diasPrestamo` tinyint(4) DEFAULT NULL,
  `fk_autor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_libro`
--

INSERT INTO `tbl_libro` (`lib_isbn`, `lib_titulo`, `lib_genero`, `lib_editorial`, `lib_numeroPaginas`, `lib_diasPrestamo`, `fk_autor`) VALUES
(1234567890, 'El Sueño de los Susurros', 'novela', NULL, 275, 7, NULL),
(1357924680, 'El Jardín de las Mariposas Perdidas', 'novela', NULL, 536, 7, NULL),
(2468135790, 'La Melodía de la Oscuridad', 'romance', NULL, 189, 3, NULL),
(2718281828, 'El Bosque de los Suspiros', 'novela', NULL, 397, 2, NULL),
(3141592653, 'El Secreto de las Estrellas Olvidadas', 'misterio', NULL, 203, 7, NULL),
(5555555555, 'La Última Llave del Destino', 'cuento', NULL, 503, 3, NULL),
(8642097531, 'El Reloj de Arena Infinito', 'novela', NULL, 321, 7, NULL),
(8888888888, 'La Ciudad de los Susurros', 'misterio', NULL, 274, 1, NULL),
(9517530862, 'Las Crónicas del Eco Silencioso', 'fantasía', NULL, 448, 7, NULL),
(9876543210, 'El Laberinto de los Recuerdos', 'cuento', NULL, 412, 7, NULL),
(9999999999, 'El Enigma de los Espejos Rotos', 'romance', NULL, 156, 3, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_prestamo`
--

CREATE TABLE `tbl_prestamo` (
  `pres_id` varchar(20) NOT NULL,
  `pres_fechaPrestamo` date DEFAULT NULL,
  `pres_fechaDevolucion` date DEFAULT NULL,
  `soc_copiaNumero` int(11) DEFAULT NULL,
  `lib_copiaISBN` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_socio`
--

CREATE TABLE `tbl_socio` (
  `soc_numero` int(11) NOT NULL,
  `soc_nombre` varchar(45) DEFAULT NULL,
  `soc_apellido` varchar(45) DEFAULT NULL,
  `soc_direccion` varchar(255) DEFAULT NULL,
  `soc_telefono` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_socio`
--

INSERT INTO `tbl_socio` (`soc_numero`, `soc_nombre`, `soc_apellido`, `soc_direccion`, `soc_telefono`) VALUES
(1, 'Ana', 'Ruiz', 'Nueva Dir 123', '3001112233'),
(2, 'Andrés', 'Galindo', 'Avenida del Sol', '3002223344'),
(3, 'Juan', 'González', 'Calle Principal', '301234567'),
(4, 'María', 'Rodríguez', 'Carrera del Río', '3012345678'),
(5, 'Pedro', 'Martínez', 'Calle del Bosque', '1234567812'),
(6, 'Ana', 'López', 'Avenida Central', '6123456781'),
(7, 'Carlos', 'Sánchez', 'Calle de la Luna', '1123456781'),
(8, 'Laura', 'Ramírez', 'Carrera del Mar', '1312345678'),
(9, 'Luis', 'Hernández', 'Avenida Montaña', '6101234567'),
(10, 'Andrea', 'García', 'Calle del Sol', '111234567'),
(1234567, 'Yefer', 'Y', 'Calle 72 # 2', '2928088');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipoautores`
--

CREATE TABLE `tbl_tipoautores` (
  `copiaISBN` bigint(20) NOT NULL,
  `copiaAutor` int(11) NOT NULL,
  `tipoAutor` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_tipoautores`
--

INSERT INTO `tbl_tipoautores` (`copiaISBN`, `copiaAutor`, `tipoAutor`) VALUES
(1234567890, 123, 'Autor'),
(1234567890, 456, 'Coautor'),
(1357924680, 123, 'Traductor'),
(2468135790, 234, 'Autor'),
(2718281828, 789, 'Traductor'),
(3141592653, 901, 'Autor'),
(5555555555, 678, 'Autor'),
(8642097531, 345, 'Autor'),
(8888888888, 234, 'Autor'),
(8888888888, 345, 'Coautor'),
(9517530862, 432, 'Traductor'),
(9517530862, 890, 'Autor'),
(9876543210, 567, 'Autor'),
(9999999999, 98, 'Autor');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_libros_autores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_libros_autores` (
`lib_titulo` varchar(255)
,`aut_apellido` varchar(45)
,`tipoAutor` varchar(20)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_libros_autores`
--
DROP TABLE IF EXISTS `vista_libros_autores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_libros_autores`  AS SELECT `l`.`lib_titulo` AS `lib_titulo`, `a`.`aut_apellido` AS `aut_apellido`, `t`.`tipoAutor` AS `tipoAutor` FROM ((`tbl_libro` `l` join `tbl_tipoautores` `t` on(`l`.`lib_isbn` = `t`.`copiaISBN`)) join `tbl_autor` `a` on(`t`.`copiaAutor` = `a`.`aut_codigo`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `audi_autor`
--
ALTER TABLE `audi_autor`
  ADD PRIMARY KEY (`id_audi`);

--
-- Indices de la tabla `audi_libro`
--
ALTER TABLE `audi_libro`
  ADD PRIMARY KEY (`id_audi`);

--
-- Indices de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  ADD PRIMARY KEY (`id_audi`);

--
-- Indices de la tabla `tbl_autor`
--
ALTER TABLE `tbl_autor`
  ADD PRIMARY KEY (`aut_codigo`);

--
-- Indices de la tabla `tbl_libro`
--
ALTER TABLE `tbl_libro`
  ADD PRIMARY KEY (`lib_isbn`);

--
-- Indices de la tabla `tbl_prestamo`
--
ALTER TABLE `tbl_prestamo`
  ADD PRIMARY KEY (`pres_id`),
  ADD KEY `fk_prestamo_libro` (`lib_copiaISBN`),
  ADD KEY `fk_prestamo_socio` (`soc_copiaNumero`);

--
-- Indices de la tabla `tbl_socio`
--
ALTER TABLE `tbl_socio`
  ADD PRIMARY KEY (`soc_numero`);

--
-- Indices de la tabla `tbl_tipoautores`
--
ALTER TABLE `tbl_tipoautores`
  ADD PRIMARY KEY (`copiaISBN`,`copiaAutor`),
  ADD KEY `fk_tipo_autor` (`copiaAutor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `audi_autor`
--
ALTER TABLE `audi_autor`
  MODIFY `id_audi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `audi_libro`
--
ALTER TABLE `audi_libro`
  MODIFY `id_audi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  MODIFY `id_audi` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_prestamo`
--
ALTER TABLE `tbl_prestamo`
  ADD CONSTRAINT `fk_prestamo_libro` FOREIGN KEY (`lib_copiaISBN`) REFERENCES `tbl_libro` (`lib_isbn`),
  ADD CONSTRAINT `fk_prestamo_socio` FOREIGN KEY (`soc_copiaNumero`) REFERENCES `tbl_socio` (`soc_numero`);

--
-- Filtros para la tabla `tbl_tipoautores`
--
ALTER TABLE `tbl_tipoautores`
  ADD CONSTRAINT `fk_tipo_autor` FOREIGN KEY (`copiaAutor`) REFERENCES `tbl_autor` (`aut_codigo`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tipo_libro` FOREIGN KEY (`copiaISBN`) REFERENCES `tbl_libro` (`lib_isbn`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
