-- =========================================
-- Crear base de datos
-- =========================================
CREATE DATABASE ejer10_tp3_2025;
GO

USE ejer10_tp3_2025;
GO

-- =========================================
-- Tablas principales
-- =========================================
CREATE TABLE paciente (
    id_paciente     INT IDENTITY PRIMARY KEY,
    documento       VARCHAR(20) NOT NULL,
    apellido        VARCHAR(80) NOT NULL,
    nombre          VARCHAR(80) NOT NULL,
    fecha_nac       DATE NULL,
    sexo            CHAR(1) NULL,
    domicilio       VARCHAR(200) NULL,
    telefono        VARCHAR(30) NULL,
    CONSTRAINT UQ_paciente_documento UNIQUE (documento),
    CONSTRAINT CHK_paciente_sexo CHECK (sexo IN ('M', 'F')),
    CONSTRAINT CHK_paciente_documento CHECK (LEN(documento) >= 8)
);

CREATE TABLE especialidad (
    id_especialidad INT IDENTITY PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_especialidad_nombre UNIQUE (nombre)
);

CREATE TABLE medico (
    id_medico       INT IDENTITY PRIMARY KEY,
    matricula       VARCHAR(30) NOT NULL,
    apellido        VARCHAR(80) NOT NULL,
    nombre          VARCHAR(80) NOT NULL,
    id_especialidad INT NOT NULL,
    CONSTRAINT UQ_medico_matricula UNIQUE (matricula),
    CONSTRAINT FK_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

CREATE TABLE atencion (
    id_atencion   INT IDENTITY PRIMARY KEY,
    id_paciente   INT NOT NULL,
    id_medico     INT NOT NULL,
    fecha         DATETIME2 NOT NULL,
    motivo        VARCHAR(250) NULL,
    diagnostico   VARCHAR(400) NULL,
    CONSTRAINT FK_atencion_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente) ON DELETE CASCADE,
    CONSTRAINT FK_atencion_medico FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    CONSTRAINT CHK_atencion_fecha CHECK (fecha <= GETDATE()),
    CONSTRAINT UQ_atencion_unica UNIQUE (id_paciente, id_medico, fecha)
);

CREATE TABLE tratamiento (
    id_tratamiento INT IDENTITY PRIMARY KEY,
    nombre         VARCHAR(120) NOT NULL,
    descripcion    VARCHAR(400) NULL,
    CONSTRAINT UQ_tratamiento_nombre UNIQUE (nombre)
);

CREATE TABLE atencion_tratamiento (
    id_atencion     INT NOT NULL,
    id_tratamiento  INT NOT NULL,
    dosis           VARCHAR(80) NULL,
    frecuencia      VARCHAR(80) NULL,
    duracion_dias   INT NULL,
    observaciones   VARCHAR(250) NULL,
    CONSTRAINT PK_atencion_tratamiento PRIMARY KEY (id_atencion, id_tratamiento),
    CONSTRAINT FK_atencion_tratamiento_atencion FOREIGN KEY (id_atencion) REFERENCES atencion(id_atencion) ON DELETE CASCADE,
    CONSTRAINT FK_atencion_tratamiento_tratamiento FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento),
    CONSTRAINT CHK_atencion_tratamiento_duracion CHECK (duracion_dias >= 0)
);

-- =========================================
-- Datos válidos (deben insertarse sin error)
-- =========================================
INSERT INTO paciente (documento, apellido, nombre, fecha_nac, sexo, domicilio, telefono) VALUES
('12345678', 'martinez', 'ana', '1990-05-10', 'F', 'av. siempre viva 123', '3794-111111'),
('87654321', 'fernandez', 'luis', '1985-08-15', 'M', 'calle falsa 456', '3794-222222');

INSERT INTO especialidad (nombre) VALUES
('cardiologia'),
('pediatria');

INSERT INTO medico (matricula, apellido, nombre, id_especialidad) VALUES
('mat001', 'gomez', 'laura', 1),
('mat002', 'perez', 'carlos', 2);

INSERT INTO atencion (id_paciente, id_medico, fecha, motivo, diagnostico) VALUES
(1, 1, '2025-09-10 10:30', 'dolor en el pecho', 'angina leve'),
(2, 2, '2025-09-11 14:00', 'fiebre alta', 'gripe');

INSERT INTO tratamiento (nombre, descripcion) VALUES
('ibuprofeno', 'antiinflamatorio y analgesico'),
('reposo', 'descanso absoluto por 3 dias');

INSERT INTO atencion_tratamiento (id_atencion, id_tratamiento, dosis, frecuencia, duracion_dias, observaciones) VALUES
(1, 1, '400mg', 'cada 8 horas', 5, 'tomar con comida'),
(2, 2, NULL, NULL, 3, 'evitar esfuerzos');

-- =========================================
-- Datos inválidos (cada uno viola una restricción distinta)
-- =========================================

--  Viola UQ_paciente_documento (documento duplicado)
INSERT INTO paciente (documento, apellido, nombre) VALUES
('12345678', 'lopez', 'pedro');

--  Viola CHK_paciente_sexo (valor no permitido)
INSERT INTO paciente (documento, apellido, nombre, sexo) VALUES
('99999999', 'garcia', 'maria', 'X');

--  Viola CHK_paciente_documento (menos de 8 caracteres)
INSERT INTO paciente (documento, apellido, nombre) VALUES
('1234', 'ruiz', 'juan');

--  Viola CHK_atencion_fecha (fecha futura)
INSERT INTO atencion (id_paciente, id_medico, fecha) VALUES
(1, 1, '2099-01-01');

--  Viola CHK_atencion_tratamiento_duracion (duración negativa)
INSERT INTO atencion_tratamiento (id_atencion, id_tratamiento, duracion_dias) VALUES
(1, 1, -5);

--  Viola FK_medico_especialidad (especialidad inexistente)
INSERT INTO medico (matricula, apellido, nombre, id_especialidad) VALUES
('mat999', 'falso', 'medico', 99);

--  Viola FK_atencion_paciente (paciente inexistente)
INSERT INTO atencion (id_paciente, id_medico, fecha) VALUES
(99, 1, '2025-09-12');

--  Viola FK_atencion_tratamiento_tratamiento (tratamiento inexistente)
INSERT INTO atencion_tratamiento (id_atencion, id_tratamiento) VALUES
(1, 99);

--  Viola UQ_atencion_unica (misma combinación paciente-médico-fecha)
INSERT INTO atencion (id_paciente, id_medico, fecha) VALUES
(1, 1, '2025-09-10 10:30');

-- =========================================
-- Consultas de verificación
-- =========================================

-- Ver atenciones con paciente, médico y especialidad
SELECT 
    a.id_atencion,
    p.apellido + ', ' + p.nombre AS paciente,
    m.apellido + ', ' + m.nombre AS medico,
    e.nombre AS especialidad,
    a.fecha,
    a.motivo,
    a.diagnostico
FROM atencion a
JOIN paciente p ON a.id_paciente = p.id_paciente
JOIN medico m ON a.id_medico = m.id_medico
JOIN especialidad e ON m.id_especialidad = e.id_especialidad;


-- Ver tratamientos aplicados en cada atención
SELECT 
    atn.id_atencion,
    t.nombre AS tratamiento,
    atn.dosis,
    atn.frecuencia,
    atn.duracion_dias,
    atn.observaciones
FROM atencion_tratamiento atn
JOIN tratamiento t ON atn.id_tratamiento = t.id_tratamiento;

