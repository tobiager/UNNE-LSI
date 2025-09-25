CREATE DATABASE solucion_primer_parcial_2025;
GO
USE solucion_primer_parcial_2025;
GO

-- catálogos
CREATE TABLE continente (
  continente_id INT NOT NULL,
  nombre        VARCHAR(40) NOT NULL,
  CONSTRAINT PK_continente PRIMARY KEY (continente_id),
  CONSTRAINT UQ_continente_nombre UNIQUE (nombre)
);

CREATE TABLE pais (
  pais_id       INT NOT NULL,
  nombre        VARCHAR(40) NOT NULL,
  continente_id INT NOT NULL,
  CONSTRAINT PK_pais PRIMARY KEY (pais_id),
  CONSTRAINT UQ_pais_nombre UNIQUE (nombre),
  CONSTRAINT FK_pais_continente
    FOREIGN KEY (continente_id) REFERENCES continente(continente_id)
);

CREATE TABLE genero (
  genero_id INT NOT NULL,
  nombre    VARCHAR(40) NOT NULL,
  CONSTRAINT PK_genero PRIMARY KEY (genero_id),
  CONSTRAINT UQ_genero_nombre UNIQUE (nombre)
);

CREATE TABLE tipo_evento (
  tipo_evento_id INT NOT NULL,
  nombre         VARCHAR(40) NOT NULL,
  CONSTRAINT PK_tipo_evento PRIMARY KEY (tipo_evento_id),
  CONSTRAINT UQ_tipo_evento_nombre UNIQUE (nombre)
);

CREATE TABLE tipo_lugar (
  tipo_lugar_id INT NOT NULL,
  nombre        VARCHAR(40) NOT NULL,
  CONSTRAINT PK_tipo_lugar PRIMARY KEY (tipo_lugar_id),
  CONSTRAINT UQ_tipo_lugar_nombre UNIQUE (nombre)
);

CREATE TABLE categoria_lugar (
  categoria_lugar_id INT NOT NULL,
  nombre             VARCHAR(40) NOT NULL,
  CONSTRAINT PK_categoria_lugar PRIMARY KEY (categoria_lugar_id),
  CONSTRAINT UQ_categoria_lugar_nombre UNIQUE (nombre),
  CONSTRAINT CK_categoria_lugar_nombre CHECK (nombre IN ('Nacional','Exterior'))
);

-- lugar 
CREATE TABLE lugar (
  lugar_id           INT NOT NULL,
  nombre             VARCHAR(40) NOT NULL,
  direccion          VARCHAR(80) NOT NULL,
  capacidad_max      INT NOT NULL,
  tipo_lugar_id      INT NOT NULL,
  categoria_lugar_id INT NOT NULL,
  CONSTRAINT PK_lugar PRIMARY KEY (lugar_id),
  CONSTRAINT UQ_lugar_nombre UNIQUE (nombre),
  CONSTRAINT CK_lugar_capacidad_pos CHECK (capacidad_max > 0),
  CONSTRAINT FK_lugar_tipo
    FOREIGN KEY (tipo_lugar_id) REFERENCES tipo_lugar(tipo_lugar_id),
  CONSTRAINT FK_lugar_categoria
    FOREIGN KEY (categoria_lugar_id) REFERENCES categoria_lugar(categoria_lugar_id)
);

-- artista 
CREATE TABLE artista (
  artista_id INT NOT NULL,
  nombre     VARCHAR(40) NOT NULL,
  cantidad   INT NOT NULL,
  genero_id  INT NOT NULL,
  pais_id    INT NOT NULL,
  CONSTRAINT PK_artista PRIMARY KEY (artista_id),
  CONSTRAINT UQ_artista_nombre UNIQUE (nombre),
  CONSTRAINT CK_artista_cantidad_min CHECK (cantidad >= 1),
  CONSTRAINT FK_artista_genero FOREIGN KEY (genero_id) REFERENCES genero(genero_id),
  CONSTRAINT FK_artista_pais   FOREIGN KEY (pais_id)   REFERENCES pais(pais_id)
);

-- evento 
CREATE TABLE evento (
  evento_id       INT NOT NULL,
  nombre          VARCHAR(40) NOT NULL,
  fecha_inicio    DATE NOT NULL
                  CONSTRAINT DF_evento_fecha_inicio DEFAULT (CAST(GETDATE() AS DATE)),
  fecha_fin       DATE NULL,
  total_entradas  INT NOT NULL,
  cantidad_vendida INT NOT NULL
                  CONSTRAINT DF_evento_cant_vendida DEFAULT (0),
  tipo_evento_id  INT NOT NULL,
  lugar_id        INT NOT NULL,
  CONSTRAINT PK_evento PRIMARY KEY (evento_id),
  CONSTRAINT CK_evento_fechas CHECK (fecha_fin IS NULL OR fecha_inicio <= fecha_fin),
  CONSTRAINT CK_evento_total_pos CHECK (total_entradas > 0),
  CONSTRAINT CK_evento_vendida_rango
      CHECK (cantidad_vendida >= 0 AND cantidad_vendida <= total_entradas),
  CONSTRAINT FK_evento_tipo  FOREIGN KEY (tipo_evento_id) REFERENCES tipo_evento(tipo_evento_id),
  CONSTRAINT FK_evento_lugar FOREIGN KEY (lugar_id)       REFERENCES lugar(lugar_id)
);

-- actuacion 
CREATE TABLE actuacion (
  evento_id   INT NOT NULL,
  artista_id  INT NOT NULL,
  hora_inicio TIME NOT NULL,
  duracion    INT  NOT NULL,
  CONSTRAINT PK_actuacion PRIMARY KEY (evento_id, artista_id),
  CONSTRAINT CK_actuacion_duracion_min CHECK (duracion > 0),
  CONSTRAINT FK_actuacion_evento  FOREIGN KEY (evento_id)  REFERENCES evento(evento_id),
  CONSTRAINT FK_actuacion_artista FOREIGN KEY (artista_id) REFERENCES artista(artista_id)
);
