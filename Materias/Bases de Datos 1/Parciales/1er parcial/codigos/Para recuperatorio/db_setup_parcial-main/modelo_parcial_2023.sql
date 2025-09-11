CREATE DATABASE asistencia_V2;

GO
USE asistencia_V2;
GO

CREATE TABLE NIVEL
(
  id_nivel INT NOT NULL,
  telefono VARCHAR (50) NOT NULL,
  razon_social VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  CONSTRAINT PK_NIVEL_id PRIMARY KEY (id_nivel)
);

CREATE TABLE TIPO_NIVEL
(
  id_tipo_nivel INT NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  id_nivel INT NOT NULL,
  CUIT VARCHAR(50) NOT NULL,
  CONSTRAINT PK_TIPO_NIVEL_id PRIMARY KEY (id_tipo_nivel),
  CONSTRAINT FK_TIPO_NIVEL_id_CUIT FOREIGN KEY (id_nivel) REFERENCES NIVEL(id_nivel)
);

CREATE TABLE TERMINAL_BIOMETRICA
(
  nro_serie INT NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  fecha_instalacion DATE NOT NULL,
  CONSTRAINT PK_TERMINAL_BIOMETRICA_nro_serie PRIMARY KEY (nro_serie)
);


CREATE TABLE PERSONAL
(
  CUIL INT NOT NULL,
  nombre_ VARCHAR(50) NOT NULL,
  Apellido VARCHAR(50) NOT NULL,
  dni varchar(50) NOT NULL,
  nro_legajo INT NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  email VARCHAR(50) NOT NULL,
  telefono_celular INT NOT NULL,
  enlace_web VARCHAR(50),
  obs_medica VARCHAR(50),
  nro_serie INT NOT NULL,
  CONSTRAINT PK_PERSONAL_CUIL PRIMARY KEY (CUIL),
  CONSTRAINT FK_PERSONAL_NROSERIE FOREIGN KEY (nro_serie) REFERENCES TERMINAL_BIOMETRICA(nro_serie),
  CONSTRAINT UQ_PERSONAL_DNI UNIQUE (dni),
  CONSTRAINT UQ_PERSONAL_legajo UNIQUE (nro_legajo),
);

CREATE TABLE ASISTENCIA_PERSONAL
(
  id_asistencia INT NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  tipo_moviemiento CHAR(1) NOT NULL,
  nro_serie INT NOT NULL,
  CONSTRAINT PK_ASISTENCIA_PERSONAL_id_asistencia PRIMARY KEY (id_asistencia),
  CONSTRAINT FK_ASISTENCIA_PERSONAL_nro__serie FOREIGN KEY (nro_serie) REFERENCES TERMINAL_BIOMETRICA(nro_serie)
);

CREATE TABLE PERSONAL_NIVEL
(
  id_nivel INT NOT NULL,
  CUIL INT NOT NULL,
  CONSTRAINT PK_PERSONAL_NIVEL_id PRIMARY KEY (id_nivel, CUIL),
  CONSTRAINT FK_PERSONAL_NIVEL_id FOREIGN KEY (id_nivel) REFERENCES NIVEL(id_nivel),
  CONSTRAINT FK_PERSONAL_NIVEL_id_CUIL FOREIGN KEY (CUIL) REFERENCES PERSONAL(CUIL)
);

--RESTRICCIONES--

ALTER TABLE PERSONAL
ADD CONSTRAINT UQ_PERSONAL_email
UNIQUE (email);

ALTER TABLE PERSONAL
ADD CONSTRAINT CK_PERSONAL_FECHA
CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) <= 65);

ALTER TABLE ASISTENCIA_PERSONAL
ADD CONSTRAINT DF_FECHA
DEFAULT CONVERT(TIME, GETDATE()) FOR hora;

ALTER TABLE ASISTENCIA_PERSONAL
ADD CONSTRAINT CK_ASISTENCIA_PERSONAL_MOV
CHECK (tipo_moviemiento IN ('I', 'E'));

--LOTES DE DATOS--

select * from ASISTENCIA_PERSONAL;
select * from NIVEL;

INSERT INTO NIVEL (id_nivel, telefono, razon_social, direccion, email) VALUES
(1, '3794836373', 'SA', 'quintana 1675',  'gastonrodriguez401@gmail.com');  

select * from tipo_nivel;

INSERT INTO tipo_nivel(id_tipo_nivel, descripcion, id_nivel, cuit) VALUES 
(1, 'Pre-primario', 1, '180020020'), 
(2, 'Primario', 1, '1800210-00'), 
(3, 'Secundario', 1, '1800220-00'),
(4, 'Superior', 1, '1800230-00');

select * from Personal;

insert into Personal (cuil, nombre_, Apellido, dni, nro_legajo, fecha_nacimiento, email, telefono_celular, enlace_web, obs_medica, nro_serie) values 
(2744, 'Luciana', 'Fernandez', '32732916', 5664, '2002-06-03', 'lucianafl@gmail.com', 3794, 'facebook', 'inestable', 001);

insert into dbo.Personal (cuil, nombre_, Apellido, dni, nro_legajo, fecha_nacimiento, email, telefono_celular, obs_medica, nro_serie) values 
('2741159206','Jezabel','Coronas', 41159206, 54098,1998-05-11, 'priscilajcoronas@gmail.com', 3794868523,'Autismo');

ALTER TABLE NIVEL 
ALTER COLUMN CUIT bigint;

ALTER TABLE NIVEL 
ALTER COLUMN telefono bigint;

DROP TABLE NIVEL;

select * from TERMINAL_BIOMETRICA;

insert into TERMINAL_BIOMETRICA (nro_serie, modelo, fecha_instalacion) VALUES 
(001, 'RX', '2024-09-14'); 

--VALORES PARA CONTROLAR LAS RESTRICIONES--

insert into Personal (cuil, nombre_, Apellido, dni, nro_legajo, fecha_nacimiento, email, telefono_celular, enlace_web, obs_medica, nro_serie) values 
(2744, 'Juan', 'Perez', '32732916', 5664, '2002-06-03', 'lucianafl@gmail.com', 3794, 'facebook', 'inestable', 001);

insert into Personal (cuil, nombre_, Apellido, dni, nro_legajo, fecha_nacimiento, email, telefono_celular, enlace_web, obs_medica, nro_serie) values 
(2712, 'Pablo', 'BEck', '32732916', 5664, '1950-06-03', 'lucianafl@gmail.com', 3794, 'facebook', 'inestable', 001);

insert into Personal (cuil, nombre_, Apellido, dni, nro_legajo, fecha_nacimiento, email, telefono_celular, enlace_web, obs_medica, nro_serie) values 
(2712, 'Pablo', 'BEck', '32732916', 5665, '1950-06-03', 'lucianafl@gmail.com', 3794, 'facebook', 'inestable', 001);

insert into Personal (cuil, nombre_, Apellido, dni, nro_legajo, fecha_nacimiento, email, telefono_celular, enlace_web, obs_medica, nro_serie) values 
(2712, 'Pablo', 'BEck', '123456789', 5665, '1950-06-03', 'lucianafl@gmail.com', 3794, 'facebook', 'inestable', 001);

insert into Personal (cuil, nombre_, Apellido, dni, nro_legajo, fecha_nacimiento, email, telefono_celular, enlace_web, obs_medica, nro_serie) values 
(2712, 'Pablo', 'BEck', '32982916', 5665, '1950-06-03', 'lucianafl123456@gmail.com', 3794, 'facebook', 'inestable', 001);

