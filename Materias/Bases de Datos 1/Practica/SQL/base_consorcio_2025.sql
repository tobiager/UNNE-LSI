/*
use master
go
-------------------
IF (select name from sys.databases where name ='base_consorcio_2025') is not null  
    DROP DATABASE base_consorcio_2025;
go
CREATE DATABASE base_consorcio_2025;
*/
go
USE base_consorcio_2025;
go

-------------------
if object_id('gasto') is not null DROP TABLE gasto;
go
if object_id('edificio') is not null DROP TABLE edificio;
go
if object_id('localidad') is not null DROP TABLE localidad;
go
if object_id('provincia') is not null DROP TABLE provincia;
go
if object_id('zona') is not null DROP TABLE zona;
go
if object_id('conserje') is not null DROP TABLE conserje;
go
if object_id('administrador') is not null DROP TABLE administrador;
go
if object_id('persona') is not null DROP TABLE persona;
go
if object_id('tipo_gasto') is not null DROP TABLE tipo_gasto;
go

-------------------
Create table provincia (
    provincia_id int primary key, 
    nombre varchar(50),
    superficie_km2 int,
    cantidad_departamentos int,
    poblacion int,
    capital varchar(50)
);
go

-------------------
Create table localidad (
    provincia_id int, 
    localidad_id int, 
    nombre varchar(50),
    Constraint pk_localidad PRIMARY KEY (provincia_id, localidad_id),
    Constraint fk_localidad_provincia FOREIGN KEY (provincia_id)  
        REFERENCES provincia(provincia_id)
);
go

-------------------
Create table zona (
    zona_id int identity primary key, 
    nombre varchar(50)
);
go

-------------------
Create table persona (
    persona_id int identity primary key, 
    apellido_nombre varchar(50),
    telefono varchar(20),
    sexo varchar(1) NOT NULL 
        Constraint ck_persona_sexo CHECK (sexo IN ('F', 'M', 'X')),
    fecha_nacimiento datetime,
    estado_civil varchar(1) NULL default ('S') 
        Constraint ck_persona_estado_civil CHECK (estado_civil IN ('S', 'C','D','O'))
);
go

-------------------
Create table conserje (
    conserje_id int primary key,
    jornada_laboral varchar(1) NULL default ('C') 
        Constraint ck_conserje_jornada_laboral CHECK (jornada_laboral IN ('M', 'C')),
    Constraint fk_conserje_persona FOREIGN KEY (conserje_id) 
        REFERENCES persona(persona_id)
);
go

-------------------
Create table administrador ( 
    administrador_id int primary key,
    vive_ahi varchar(1) NULL default ('N') 
        Constraint ck_administrador_vive_ahi CHECK (vive_ahi IN ('S', 'N')),
    Constraint fk_administrador_persona FOREIGN KEY (administrador_id) 
        REFERENCES persona(persona_id)
);
go

-------------------
Create table tipo_gasto (
    tipo_gasto_id int primary key, 
    nombre varchar(50)
);
go

-------------------
Create table edificio (
    provincia_id int,
    localidad_id int,
    edificio_id int, 
    nombre varchar(50),
    direccion varchar(250),					     
    zona_id int,	
    conserje_id int,	
    administrador_id int,	
    Constraint pk_edificio PRIMARY KEY (provincia_id, localidad_id, edificio_id),
    Constraint fk_edificio_localidad FOREIGN KEY (provincia_id, localidad_id)  
        REFERENCES localidad(provincia_id, localidad_id),
    Constraint fk_edificio_zona FOREIGN KEY (zona_id)  
        REFERENCES zona(zona_id),
    Constraint fk_edificio_conserje FOREIGN KEY (conserje_id)  
        REFERENCES conserje(conserje_id),
    Constraint fk_edificio_administrador FOREIGN KEY (administrador_id)  
        REFERENCES administrador(administrador_id)
);
go

-------------------
Create table gasto (
    gasto_id int identity primary key,
    provincia_id int,
    localidad_id int,
    edificio_id int, 
    periodo int,
    fecha_pago datetime,					     
    tipo_gasto_id int,
    importe decimal (8,2),	
    Constraint fk_gasto_edificio FOREIGN KEY (provincia_id, localidad_id, edificio_id)  
        REFERENCES edificio(provincia_id, localidad_id, edificio_id),
    Constraint fk_gasto_tipo FOREIGN KEY (tipo_gasto_id)  
        REFERENCES tipo_gasto(tipo_gasto_id)
);
go