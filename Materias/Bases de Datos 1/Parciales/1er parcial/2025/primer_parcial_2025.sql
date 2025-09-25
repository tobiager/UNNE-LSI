CREATE DATABASE solucion_primer_parcial_2025;
GO
USE solucion_primer_parcial_2025;
GO

-- catálogos
CREATE TABLE continente (
  continente_id INT PRIMARY KEY,
  nombre        VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE pais (
  pais_id       INT PRIMARY KEY,
  nombre        VARCHAR(40) NOT NULL UNIQUE,
  continente_id INT NOT NULL,
  CONSTRAINT FK_pais_continente
    FOREIGN KEY (continente_id) REFERENCES continente(continente_id)
);

CREATE TABLE genero (
  genero_id INT PRIMARY KEY,
  nombre    VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE tipo_evento (
  tipo_evento_id INT PRIMARY KEY,
  nombre         VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE tipo_lugar (
  tipo_lugar_id INT PRIMARY KEY,
  nombre        VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE categoria_lugar (
  categoria_lugar_id INT PRIMARY KEY,
  nombre             VARCHAR(40) NOT NULL UNIQUE
);

-- lugar 
CREATE TABLE lugar (
  lugar_id           INT PRIMARY KEY,
  nombre             VARCHAR(40) NOT NULL UNIQUE,
  direccion          VARCHAR(80) NOT NULL,
  capacidad_max      INT NOT NULL CHECK (capacidad_max > 0),
  tipo_lugar_id      INT NOT NULL,
  categoria_lugar_id INT NOT NULL,
  pais_id            INT NOT NULL,
  CONSTRAINT FK_lugar_tipo
    FOREIGN KEY (tipo_lugar_id) REFERENCES tipo_lugar(tipo_lugar_id),
  CONSTRAINT FK_lugar_categoria
    FOREIGN KEY (categoria_lugar_id) REFERENCES categoria_lugar(categoria_lugar_id),
  CONSTRAINT FK_lugar_pais
    FOREIGN KEY (pais_id) REFERENCES pais(pais_id),
  -- restricción Argentina/Exterior
  CONSTRAINT CK_categoria_arg_ext
    CHECK ((pais_id = 1 AND categoria_lugar_id = 1) OR (pais_id <> 1 AND categoria_lugar_id = 2)
);

-- artista 
CREATE TABLE artista (
  artista_id INT PRIMARY KEY,
  nombre     VARCHAR(40) NOT NULL UNIQUE,
  cantidad   INT NOT NULL CHECK (cantidad >= 1),
  tipo       VARCHAR(10) NOT NULL,
  genero_id  INT NOT NULL,
  pais_id    INT NOT NULL,
  CONSTRAINT FK_artista_genero FOREIGN KEY (genero_id) REFERENCES genero(genero_id),
  CONSTRAINT FK_artista_pais   FOREIGN KEY (pais_id)   REFERENCES pais(pais_id),
  -- restricción solista/banda
  CONSTRAINT CK_artista_solista_bandaCHECK ((cantidad = 1 AND tipo = 'Solista') OR (cantidad > 1 AND tipo = 'Banda'))
);

-- evento 
CREATE TABLE evento (
  evento_id      INT PRIMARY KEY,
  nombre         VARCHAR(40) NOT NULL,
  fecha_inicio   DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
  fecha_fin      DATE NULL,
  total_entradas INT NULL CHECK (total_entradas IS NULL OR total_entradas > 0),
  tipo_evento_id INT NOT NULL,
  lugar_id       INT NOT NULL,
  CONSTRAINT CK_evento_fechas CHECK (fecha_fin IS NULL OR fecha_inicio <= fecha_fin),
  CONSTRAINT FK_evento_tipo  FOREIGN KEY (tipo_evento_id) REFERENCES tipo_evento(tipo_evento_id),
  CONSTRAINT FK_evento_lugar FOREIGN KEY (lugar_id)       REFERENCES lugar(lugar_id)
);

-- actuacion 
CREATE TABLE actuacion (
  evento_id   INT NOT NULL,
  artista_id  INT NOT NULL,
  hora_inicio TIME NOT NULL,
  duracion    TIME NOT NULL,
  CONSTRAINT PK_actuacion PRIMARY KEY (evento_id, artista_id),
  CONSTRAINT FK_actuacion_evento  FOREIGN KEY (evento_id)  REFERENCES evento(evento_id),
  CONSTRAINT FK_actuacion_artista FOREIGN KEY (artista_id) REFERENCES artista(artista_id)
);
