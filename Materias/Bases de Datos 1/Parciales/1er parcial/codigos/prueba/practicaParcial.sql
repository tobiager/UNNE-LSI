--Creacion Base de Datos
CREATE DATABASE 1prueba;

GO
--Uso base de Datos
USE 1prueba;

GO

--Creacion de tablas
CREATE TABLE Dueños
(
  DNI CHAR(8) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  Calle VARCHAR(50) NOT NULL,
  numero CHAR(8) NOT NULL,
  correo_electronico VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Dueños PRIMARY KEY (DNI),
  UNIQUE (correo_electronico)
);

CREATE TABLE Veterinarios
(
  numeroLicenciaProfesional INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  horarioAtencion INT NOT NULL,
  CONSTRAINT PK_Veterinarios PRIMARY KEY (numeroLicenciaProfesional),
);

CREATE TABLE Razas
(
  id_raza INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Razas PRIMARY KEY (id_raza),
);

CREATE TABLE Dueños_telefono
(
  telefono CHAR(20) NOT NULL,
  dni CHAR(8) NOT NULL,
  PRIMARY KEY (telefono),
  FOREIGN KEY (dni) REFERENCES Dueños(dni)
);

CREATE TABLE Veterinarios_especialidad
(
  especialidad VARCHAR(50) NOT NULL,
  numeroLicenciaProfesional INT NOT NULL,
  PRIMARY KEY (especialidad, numeroLicenciaProfesional),
  FOREIGN KEY (numeroLicenciaProfesional) REFERENCES Veterinarios(numeroLicenciaProfesional)
);

CREATE TABLE Especies
(
  id_especie INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  id_raza INT NOT NULL,
  PRIMARY KEY (id_especie),
  FOREIGN KEY (id_raza) REFERENCES Razas(id_raza)
);

CREATE TABLE Mascotas
(
  id_mascota INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  fechaNacimiento DATE NOT NULL,
  peso FLOAT NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  droga VARCHAR(50) NOT NULL,
  id_especie INT NOT NULL,
  dni CHAR(8) NOT NULL,
  PRIMARY KEY (id_mascota),
  FOREIGN KEY (id_especie) REFERENCES Especies(id_especie),
  FOREIGN KEY (dni) REFERENCES Dueños(dni)
);

CREATE TABLE CitasMedicas
(
  motivo VARCHAR(50) NOT NULL,
  observacion VARCHAR(50),
  id_cita INT NOT NULL,
  fechaSistema DATE NOT NULL,
  fechaUsuario DATE NOT NULL,
  numeroLicenciaProfesional INT NOT NULL,
  id_mascota INT NOT NULL,
  PRIMARY KEY (id_cita),
  FOREIGN KEY (numeroLicenciaProfesional) REFERENCES Veterinarios(numeroLicenciaProfesional),
  FOREIGN KEY (id_mascota) REFERENCES Mascotas(id_mascota)
);

CREATE TABLE Tratamientos
(
  nombreTratamiento VARCHAR(50) NOT NULL,
  duracion FLOAT NOT NULL,
  medicamentosIndicados VARCHAR(50) NOT NULL,
  indicacionRelevante VARCHAR(50) NOT NULL,
  id_tratamiento INT NOT NULL,
  id_cita INT NOT NULL,
  PRIMARY KEY (id_tratamiento),
  FOREIGN KEY (id_cita) REFERENCES CitasMedicas(id_cita)
);

CREATE TABLE Medicamentos
(
  nombreComercial VARCHAR(50) NOT NULL,
  monodroga VARCHAR(50) NOT NULL,
  presentacion VARCHAR(50) NOT NULL,
  laboratorio VARCHAR(50) NOT NULL,
  id_medicamento INT NOT NULL,
  id_tratamiento INT NOT NULL,
  PRIMARY KEY (id_medicamento),
  FOREIGN KEY (id_tratamiento) REFERENCES Tratamientos(id_tratamiento)
);

GO
--Restricciones

