CREATE TABLE Medicamento
(
  id_medicamento INT NOT NULL,
  nombre_comercial VARCHAR(50) NOT NULL,
  monodroga_medic VARCHAR(50) NOT NULL,
  presentacion_medic VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Medicamento_id PRIMARY KEY (id_medicamento)
);

CREATE TABLE Especie
(
  id_especie INT NOT NULL,
  nombre_especie VARCHAR(30) NOT NULL,
  CONSTRAINT PK_Especie_id PRIMARY KEY (id_especie)
);

CREATE TABLE Raza
(
  id_raza INT NOT NULL,
  nombre_raza VARCHAR(30) NOT NULL,
  CONSTRAINT PK_Raza_id PRIMARY KEY (id_raza)
);

CREATE TABLE Dueno
(
  id_dueno INT NOT NULL,
  nombre_duenio VARCHAR(50) NOT NULL,
  apellido_duenio VARCHAR(50) NOT NULL,
  dni_duenio VARCHAR(30) NOT NULL UNIQUE,
  telefono_duenio INT NOT NULL UNIQUE,
  email_duenio VARCHAR(50) NOT NULL UNIQUE,
  direccion_duenio VARCHAR(30) NOT NULL,
  CONSTRAINT PK_Dueno_id PRIMARY KEY (id_dueno)  
);

CREATE TABLE Motivo_visita
(
  id_motivoVisita INT NOT NULL,
  desc_motivoVisita VARCHAR(255) NOT NULL,
  CONSTRAINT PK_Motivo_visita_id PRIMARY KEY (id_motivoVisita)
);

CREATE TABLE Especialidad
(
  id_especialidad INT NOT NULL,
  nombre_especialidad VARCHAR(30) NOT NULL,
  CONSTRAINT PK_Especialidad_id PRIMARY KEY (id_especialidad)
);

CREATE TABLE Laboratorio
(
  id_laboratorio INT NOT NULL,
  nombre_lab VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Laboratorio_id PRIMARY KEY (id_laboratorio)
);

CREATE TABLE Medicamento_Lab
(
  id_laboratorio INT NOT NULL,
  id_medicamento INT NOT NULL,
  CONSTRAINT PK_Medicamento_Lab_id PRIMARY KEY (id_laboratorio, id_medicamento),
  CONSTRAINT FK_Medicamento_Lab_id FOREIGN KEY (id_laboratorio) REFERENCES Laboratorio(id_laboratorio),
  CONSTRAINT FK_Medicamento_Lab_Medicamento FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento)
);

CREATE TABLE Mascota
(
  id_mascota INT NOT NULL,
  nombre_mascota VARCHAR(10) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  peso_mascota FLOAT NOT NULL,
  condicion_mascota VARCHAR(50),
  id_raza INT NOT NULL,
  id_especie INT NOT NULL,
  id_dueno INT NOT NULL,
  CONSTRAINT PK_Mascota_id PRIMARY KEY (id_mascota),
  CONSTRAINT FK_Mascota_id_raza FOREIGN KEY (id_raza) REFERENCES Raza(id_raza),
  CONSTRAINT FK_Mascota_id_especie FOREIGN KEY (id_especie) REFERENCES Especie(id_especie),
  CONSTRAINT FK_Mascota_id_dueno FOREIGN KEY (id_dueno) REFERENCES Dueno(id_dueno)
);

CREATE TABLE Tratamiento
(
  id_tratamiento INT NOT NULL,
  nombre_tratamiento VARCHAR(50) NOT NULL,
  inicio_tratamiento DATE NOT NULL,
  fin_tratamiento DATE NOT NULL,
  id_laboratorio INT NOT NULL,
  id_medicamento INT NOT NULL,
  CONSTRAINT PK_Tratamiento_id PRIMARY KEY (id_tratamiento),
  CONSTRAINT FK_Tratamiento_id_lab_medicamento FOREIGN KEY (id_laboratorio, id_medicamento) REFERENCES Medicamento_Lab(id_laboratorio, id_medicamento)
);

CREATE TABLE Citas_medica
(
  id_citaMedica INT NOT NULL,
  fecha_citaMedica DATE NOT NULL,
  observaciones_citaMedica INT NOT NULL,
  id_motivoVisita INT NOT NULL,
  id_tratamiento INT,
  id_mascota INT NOT NULL,
  CONSTRAINT PK_Citas_medica_id PRIMARY KEY (id_citaMedica),
  CONSTRAINT FK_Citas_medica_motivo FOREIGN KEY (id_motivoVisita) REFERENCES Motivo_visita(id_motivoVisita),
  CONSTRAINT FK_Citas_medica_tratamiento FOREIGN KEY (id_tratamiento) REFERENCES Tratamiento(id_tratamiento),
  CONSTRAINT FK_Citas_medica_id_mascota FOREIGN KEY (id_mascota) REFERENCES Mascota(id_mascota)
);

CREATE TABLE Veterinario
(
  id_veterinario INT NOT NULL,
  nro_licProfesional INT NOT NULL UNIQUE,
  nombre_profesional VARCHAR(30) NOT NULL,
  hora_entrada DATE NOT NULL,
  hora_salida DATE NOT NULL,
  id_especialidad INT NOT NULL,
  id_citaMedica INT,
  CONSTRAINT PK_Veterinario_id PRIMARY KEY (id_veterinario),
  CONSTRAINT PK_Veterinario_id_especialidad FOREIGN KEY (id_especialidad) REFERENCES Especialidad(id_especialidad),
  CONSTRAINT PK_Veterinario_id_citaMedica FOREIGN KEY (id_citaMedica) REFERENCES Citas_medica(id_citaMedica)
);


-- -----------------------------
-- Restricciones ---------------
-- -----------------------------

---

ALTER TABLE Dueno 
ADD CONSTRAINT CK_duenio_dni
CHECK (LEN(dni_duenio) <= 8);

---

ALTER TABLE Citas_medica
ADD CONSTRAINT DF_Citas_fecha
DEFAULT GETDATE() FOR fecha_citaMedica;

---

ALTER TABLE Mascota
ADD CONSTRAINT CK_Mascota_edad
CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) <= 30);

---

-- ---------------------
-- LOTES DE DATOS ------
------------------------

INSERT INTO Especie (id_especie, nombre_especie) VALUES
(1, 'Perro'),
(2, 'Gato'),
(3, 'Ave');

INSERT INTO Raza (id_raza, nombre_raza) VALUES
(1, 'Caniche'),
(2, 'Siames'),
(3, 'Loro');

INSERT INTO Especialidad (id_especialidad, nombre_especialidad) VALUES
(1, 'Ortopedia'),
(2, 'Oftalmología');

INSERT INTO Laboratorio (id_laboratorio, nombre_lab) VALUES
(1, 'ZAZA-Droga'),
(2, 'YOYO-Drogeria');

INSERT INTO Medicamento (id_medicamento, nombre_comercial, monodroga_medic, presentacion_medic) VALUES
(1, 'Ibuprofeno','Anfetamina','Pastilla'),
(2, 'Actron','Morfina','Capsula');


INSERT INTO Dueno (id_dueno, nombre_duenio, apellido_duenio, direccion_duenio, dni_duenio, telefono_duenio, email_duenio ) VALUES
(1, 'Juan', 'Pérez', 'Calle Falsa 123', 12345678, '555-1234', 'juan.perez@example.com'),
(2, 'María', 'González', 'Av. Siempreviva 456', 23456789, '555-5678', 'maria.gonzalez@example.com'),
(3, 'Carlos', 'López', 'Calle del Sol 789', 34567890, '555-9876', 'carlos.lopez@example.com');

INSERT INTO Veterinario (id_veterinario, nro_licProfesional, nombre_profesional, hora_entrada, hora_salida, id_especialidad, id_citaMedica) VALUES
(1, 'LIC1234', 'Dr. Ana Martínez', '1900-01-01 08:30:00', '1900-01-01 16:30:00', 1, NULL),
(2, 'LIC5678', 'Dr. Luis Fernández', '1900-01-01 09:00:00', '1900-01-01 17:00:00', 2, NULL),
(3, 'LIC9101', 'Dra. Elena Ruiz', '1900-01-01 07:30:00', '1900-01-01 15:30:00', 1, NULL);

INSERT INTO Mascota (id_mascota, nombre_mascota, fecha_nacimiento, peso_mascota, condicion_mascota, id_dueno, id_raza, id_especie) VALUES
(1, 'Rex', '2022-05-15', 25.5, 'Saludable', 1, 1, 1),
(2, 'Luna', '2021-08-22', 10.0, 'En tratamiento', 2, 2, 2),
(3, 'Max', '2020-11-10', 30.0, 'Saludable', 3, 3, 3);

INSERT INTO Motivo_visita (id_motivoVisita, desc_motivoVisita) VALUES
(1,'Chequeo general'),
(2,'Vacunación'),
(3,'Consulta por alergias');

INSERT INTO Citas_medica (id_citaMedica, fecha_citaMedica, observaciones_citaMedica, id_motivoVisita, id_tratamiento, id_mascota) VALUES
(1, '2024-09-20', 'Todo en orden, se recomienda revisión en 6 meses.', 1, 1, 1),
(2, '2024-09-22', 'Aplicación de vacunas y control de peso.', 2, 2, 2),
(3, '2024-09-25', 'Requiere análisis adicionales para determinar el alérgeno.', 3, 3, 3);

INSERT INTO Medicamento_Lab (id_laboratorio, id_medicamento) VALUES
(1,1),
(1,2),
(2,2);

INSERT INTO Tratamiento (id_tratamiento, nombre_tratamiento, inicio_tratamiento, fin_tratamiento, id_laboratorio, id_medicamento) VALUES
(1,'Tratamiento A','2024-09-10','2024-10-10',1,1);

