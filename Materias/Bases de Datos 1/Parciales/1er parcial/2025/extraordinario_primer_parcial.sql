/*
Extraordinario 1er parcial 20/11/25
*/

CREATE DATABASE extraordinario_primer_parcial_2025;
GO
USE extraordinario_primer_parcial_2025;
GO

/*=============================
=  TABLA: Tipo_obra_social   =
=============================*/
CREATE TABLE Tipo_obra_social
(
    id_tipo INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);
GO

/*===========================
=   TABLA: Obra_Sociales    =
===========================*/
CREATE TABLE Obra_Sociales
(
    id_obra_social INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    forma VARCHAR(10) NOT NULL CHECK (forma IN ('prestador','directa')),
    id_tipo INT NOT NULL,
    CONSTRAINT FK_obra_tipo FOREIGN KEY (id_tipo)
        REFERENCES Tipo_obra_social(id_tipo)
);
GO

/*===========================
=     TABLA: Provincia      =
===========================*/
CREATE TABLE Provincia
(
    id_provincia INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);
GO

/*===========================
     TABLA: Afiliado       
===========================*/
CREATE TABLE Afiliado
(
    id_afiliado INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    documento INT NOT NULL,
    sexo CHAR(1) NOT NULL CHECK (sexo IN ('M','F','O')),
    estado_civil CHAR(1) NOT NULL CHECK (estado_civil IN ('S','C','O')),
    fecha_nacimiento DATE NOT NULL CHECK (fecha_nacimiento <= CAST(GETDATE() AS DATE)),
    parentesco VARCHAR(30) NOT NULL DEFAULT 'Titular',
    lugar_trabajo VARCHAR(30),
    fecha_ingreso DATE NOT NULL,
    id_obra_social INT NOT NULL,

    CONSTRAINT FK_afiliado_obra FOREIGN KEY (id_obra_social)
        REFERENCES Obra_Sociales(id_obra_social)
);
GO

/*=====================================
= TABLA: Relación entre afiliados     =
= (Afiliados dependientes/familiares) =
=====================================*/
CREATE TABLE Afiliado_Depende
(
    id_afiliado_titular INT NOT NULL,
    id_afiliado_dependiente INT NOT NULL,

    CONSTRAINT FK_dep_titular FOREIGN KEY (id_afiliado_titular)
        REFERENCES Afiliado(id_afiliado),

    CONSTRAINT FK_dep_hijo FOREIGN KEY (id_afiliado_dependiente)
        REFERENCES Afiliado(id_afiliado)
);
GO

/*====================================
= TABLA: prestar_servicios_provincias
=====================================*/
CREATE TABLE prestar_servicios_provincias
(
    id_provincia INT NOT NULL,
    id_obra_social INT NOT NULL,

    CONSTRAINT FK_serv_prov FOREIGN KEY (id_provincia)
        REFERENCES Provincia(id_provincia),

    CONSTRAINT FK_serv_os FOREIGN KEY (id_obra_social)
        REFERENCES Obra_Sociales(id_obra_social)
);
GO
