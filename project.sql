-- COMANDOS CREACIÓN DE TABLAS 

DROP DATABASE IF EXISTS universidad;
CREATE DATABASE universidad;
USE universidad;

CREATE TABLE ciudad (
    id_ciudad INT(5),
    nombre_ciudad VARCHAR(50),
    PRIMARY KEY (id_ciudad)
);

CREATE TABLE direccion (
    id_direccion INT(5),
    tipo_direccion VARCHAR(50),
    direccion VARCHAR(50),
    descripcion TEXT,
    id_ciudad INT(5),
    PRIMARY KEY (id_direccion),
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE telefono (
    id_telefono INT(5),
    telefono VARCHAR(9),
    PRIMARY KEY (id_telefono)
);

CREATE TABLE departamento (
    id_departamento INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_departamento VARCHAR(50) NOT NULL
);

CREATE TABLE grado (
    id_grado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_grado VARCHAR(100) NOT NULL
);

CREATE TABLE tipo_asignatura (
    id_tipo_asignatura INT(5) AUTO_INCREMENT,
    nombre_tipo_asignatura VARCHAR(50),
    PRIMARY KEY (id_tipo_asignatura)
);

CREATE TABLE profesor (
    id_profesor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nif VARCHAR(9) UNIQUE,
    nombre_profesor VARCHAR(25) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    id_direccion INT(5),
    id_telefono INT(5),
    fecha_nacimiento DATE NOT NULL,
    sexo ENUM('H', 'M') NOT NULL,
    id_departamento INT UNSIGNED,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    FOREIGN KEY (id_telefono) REFERENCES telefono(id_telefono)
);
 
CREATE TABLE asignatura (
    id_asignatura INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_asignatura VARCHAR(100) NOT NULL,
    creditos FLOAT UNSIGNED NOT NULL,
    id_tipo_asignatura INT(5),
    curso TINYINT UNSIGNED NOT NULL,
    cuatrimestre TINYINT UNSIGNED NOT NULL,
    id_profesor INT UNSIGNED,
    id_grado INT UNSIGNED NOT NULL,
    FOREIGN KEY(id_profesor) REFERENCES profesor(id_profesor),
    FOREIGN KEY(id_tipo_asignatura) REFERENCES tipo_asignatura(id_tipo_asignatura),
    FOREIGN KEY(id_grado) REFERENCES grado(id_grado)
);

CREATE TABLE curso_escolar (
    id_curso_escolar INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    anyo_inicio YEAR NOT NULL,
    anyo_fin YEAR NOT NULL
);

CREATE TABLE alumno (
    id_alumno INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nif VARCHAR(9) UNIQUE,
    nombre_alumno VARCHAR(25) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    id_direccion INT(5),
    id_telefono INT(5),
    fecha_nacimiento DATE NOT NULL,
    sexo ENUM('H', 'M') NOT NULL,
    FOREIGN KEY (id_telefono) REFERENCES telefono(id_telefono),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE alumno_se_matricula_asignatura (
    id_alumno INT UNSIGNED NOT NULL,
    id_asignatura INT UNSIGNED NOT NULL,
    id_curso_escolar INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_alumno, id_asignatura, id_curso_escolar),
    FOREIGN KEY (id_alumno) REFERENCES alumno(id_alumno),
    FOREIGN KEY (id_asignatura) REFERENCES asignatura(id_asignatura),
    FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id_curso_escolar)
);

-- INSERCIÓN DE DATOS

INSERT INTO ciudad (id_ciudad, nombre_ciudad) VALUES
(1, 'Ciudad A'),
(2, 'Ciudad B'),
(3, 'Ciudad C'),
(4, 'Ciudad D'),
(5, 'Ciudad E');

INSERT INTO direccion (id_direccion, tipo_direccion, direccion, descripcion, id_ciudad) VALUES
(1, 'Casa', 'Calle 1', 'Cerca del parque', 1),
(2, 'Oficina', 'Avenida 2', 'Frente al supermercado', 2),
(3, 'Casa', 'Carrera 3', 'Al lado del colegio', 3),
(4, 'Oficina', 'Callejon 4', 'Detrás de la plaza', 4),
(5, 'Casa', 'Camino 5', 'Cerca del río', 5),
(6, 'Oficina', 'Avenida 6', 'En el centro de la ciudad', 1),
(7, 'Casa', 'Calle 7', 'En la zona residencial', 2),
(8, 'Oficina', 'Carrera 8', 'Junto al parque industrial', 3),
(9, 'Casa', 'Avenida 9', 'Cerca del centro comercial', 4),
(10, 'Oficina', 'Callejon 10', 'En el casco antiguo', 5),
(11, 'Casa', 'Calle 11', 'En la zona universitaria', 1),
(12, 'Oficina', 'Camino 12', 'Rodeada de naturaleza', 2),
(13, 'Casa', 'Carrera 13', 'En la periferia de la ciudad', 3),
(14, 'Oficina', 'Avenida 14', 'Cerca del puerto', 4),
(15, 'Casa', 'Callejon 15', 'En el barrio histórico', 5),
(16, 'Oficina', 'Calle 16', 'En el centro financiero', 1),
(17, 'Casa', 'Camino 17', 'En las afueras de la ciudad', 2),
(18, 'Oficina', 'Carrera 18', 'Cerca del aeropuerto', 3),
(19, 'Casa', 'Avenida 19', 'En la zona comercial', 4),
(20, 'Oficina', 'Callejon 20', 'Junto al teatro', 5),
(21, 'Casa', 'Calle 21', 'En la zona turística', 1),
(22, 'Oficina', 'Camino 22', 'En el área rural', 2),
(23, 'Casa', 'Carrera 23', 'En el distrito financiero', 3),
(24, 'Oficina', 'Avenida 24', 'Cerca del estadio', 4),
(25, 'Casa', 'Callejon 25', 'En el casco urbano', 5);

INSERT INTO telefono (id_telefono, telefono) VALUES
(1, '111111111'),
(2, '222222222'),
(3, '333333333'),
(4, '444444444'),
(5, '555555555'),
(6, '666666666'),
(7, '777777777'),
(8, '888888888'),
(9, '999999999'),
(10, '101010101'),
(11, '111111110'),
(12, '121212121'),
(13, '131313131'),
(14, '141414141'),
(15, '151515151'),
(16, '161616161'),
(17, '171717171'),
(18, '181818181'),
(19, '191919191'),
(20, '202020202'),
(21, '212121212'),
(22, '222222222'),
(23, '232323232'),
(24, '242424242'),
(25, '252525252');

INSERT INTO departamento (nombre_departamento) VALUES
('Departamento de Matemáticas'),
('Departamento de Historia'),
('Departamento de Ciencias de la Computación'),
('Departamento de Ciencias Naturales'),
('Departamento de Idiomas'),
('Departamento de Literatura');

INSERT INTO grado (nombre_grado) VALUES
('Ingeniería Informática'),
('Administración de Empresas'),
('Medicina'),
('Derecho'),
('Psicología');

INSERT INTO tipo_asignatura (nombre_tipo_asignatura) VALUES
('Básica'),
('Optativa'),
('Obligatoria');

INSERT INTO profesor (nif, nombre_profesor, apellido1, apellido2, id_direccion, id_telefono, fecha_nacimiento, sexo, id_departamento) VALUES
('12345678A', 'Juan', 'García', 'Pérez', 1, 1, '1980-05-10', 'H', 1),
('23456789B', 'María', 'López', 'Martínez', 2, 2, '1975-09-20', 'M', 2),
('34567890C', 'Pedro', 'Rodríguez', 'Gómez', 3, 3, '1985-03-15', 'H', 3),
('45678901D', 'Ana', 'Martín', 'Sánchez', 4, 4, '1978-11-25', 'M', 4),
('56789012K', 'Carlos', 'Gómez', 'Fernández', 5, 5, '1982-07-05', 'H', NULL),
('67890123F', 'Laura', 'Pérez', 'López', 6, 6, '1987-01-30', 'M', 2),
('78901234G', 'David', 'Hernández', 'García', 7, 7, '1973-12-12', 'H', 3),
('89012345K', 'Elena', 'Díaz', 'Martín', 8, 8, '1989-08-18', 'M', 4),
('90123456I', 'Sara', 'Ruiz', 'Hernández', 9, 9, '1984-04-08', 'M', 1),
('01234567J', 'Javier', 'Fernández', 'Díaz', 10, 10, '1970-06-28', 'H', NULL);

INSERT INTO asignatura (nombre_asignatura, creditos, id_tipo_asignatura, curso, cuatrimestre, id_profesor, id_grado) VALUES
('Matemáticas I', 6.0, 3, 3, 1, NULL, 1),
('Programación', 6.0, 3, 1, 1, 3, 1),
('Historia Contemporánea', 6.0, 3, 1, 1, 2, 2),
('Literatura Española', 6.0, 3, 1, 1, NULL, 2),
('Economía', 6.0, 3, 1, 1, 5, 3),
('Anatomía', 6.0, 3, 1, 1, 7, 3),
('Derecho Civil', 6.0, 3, 1, 1, 6, 4),
('Psicología General', 6.0, 3, 3, 1, 8, 4),
('Cálculo II', 6.0, 3, 2, 1, 9, 1),
('Estructura de Datos', 6.0, 3, 2, 1, 10, 1),
('Historia del Arte', 6.0, 3, 2, 1, NULL, 2),
('Literatura Universal', 6.0, 3, 2, 1, 3, 2),
('Microeconomía', 6.0, 3, 2, 1, NULL, 3),
('Fisiología', 6.0, 3, 2, 1, NULL, 3),
('Derecho Penal', 6.0, 3, 2, 1, 6, 4),
('Psicología Infantil', 6.0, 3, 2, 1, 8, 4),
('Álgebra Lineal', 6.0, 3, 3, 2, 9, 1),
('Bases de Datos', 6.0, 3, 3, 2, 10, 1),
('Historia del Mundo Antiguo', 6.0, 3, 3, 2, 1, 2),
('Literatura Comparada', 6.0, 3, 3, 2, 3, 2),
('Macroeconomía', 6.0, 3, 3, 2, 5, 3),
('Bioquímica', 6.0, 3, 3, 2, 7, 3),
('Derecho Administrativo', 6.0, 3, 3, 2, 6, 4),
('Psicología Social', 6.0, 3, 3, 2, 8, 4),
('Estadística', 6.0, 3, 4, 2, 9, 1),
('Sistemas Operativos', 6.0, 3, 4, 2, 10, 1),
('Historia del Mundo Medieval', 6.0, 3, 4, 2, 1, 2),
('Literatura del Siglo XX', 6.0, 3, 4, 2, 3, 2),
('Finanzas Corporativas', 6.0, 3, 4, 2, 5, 3),
('Farmacología', 6.0, 3, 4, 2, 7, 3),
('Derecho Internacional', 6.0, 3, 4, 2, 6, 4);

INSERT INTO curso_escolar (anyo_inicio, anyo_fin) VALUES
('2023', '2024'),
('2024', '2025'),
('2025', '2026'),
('2026', '2027');

INSERT INTO alumno (nif, nombre_alumno, apellido1, apellido2, id_direccion, id_telefono, fecha_nacimiento, sexo) VALUES
('12345678Z', 'Alejandra', 'García', 'Martínez', 11, 11, '2000-03-15', 'M'),
('23456789Y', 'Ana', 'López', 'Fernández', 12, 12, '2001-06-20', 'M'),
('34567890X', 'Pablo', 'Martín', 'Gómez', 13, 13, '2000-12-05', 'H'),
('45678901W', 'Elena', 'Sánchez', 'Rodríguez', 14, 14, '2001-09-10', 'M'),
('56789012V', 'Daniela', 'Gómez', 'Pérez', 15, 15, '2000-08-25', 'M'),
('67890123U', 'Laura', 'Hernández', 'García', 16, 16, '2001-04-30', 'M'),
('78901234T', 'Carlos', 'Díaz', 'Martínez', 17, 17, '2000-10-18', 'H'),
('89012345S', 'María', 'Muñoz', 'López', 18, 18, '2001-01-22', 'M'),
('90123456R', 'Sara', 'Torres', 'Sánchez', 19, 19, '2000-07-08', 'M'),
('01234567Q', 'Alejandro', 'Ruiz', 'Fernández', 20, 20, '2001-11-28', 'H'),
('12345678P', 'Lucía', 'García', 'Martínez', 21, 21, '2000-02-14', 'M'),
('23456789O', 'Javier', 'López', 'Fernández', 22, 22, '2001-05-16', 'H'),
('34567890N', 'Paula', 'Martín', 'Gómez', 23, 23, '2000-11-01', 'M'),
('45678901M', 'Andrea', 'Sánchez', 'Rodríguez', 24, 24, '2001-10-03', 'M'),
('56789012L', 'Andres', 'Paniagua', 'Pérez', 25, 25, '2000-09-09', 'H');

INSERT INTO alumno_se_matricula_asignatura (id_alumno, id_asignatura, id_curso_escolar) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(2, 4, 1),
(3, 5, 1),
(3, 6, 1),
(4, 7, 1),
(4, 8, 1),
(5, 9, 1),
(5, 10, 1),
(6, 11, 1),
(6, 12, 1),
(7, 13, 1),
(7, 14, 1),
(8, 15, 1);