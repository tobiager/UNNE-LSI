USE master;
GO

/* ==========================================================
   PARCIAL BD I — MODELO “Empresa”
   Alumno: (tu nombre)
   Motor: SQL Server (SSMS 20, SQL Server 2016+)
   ========================================================== */
SET NOCOUNT ON;
SET XACT_ABORT ON;

/* 1) (Re)crear Base y usarla */
IF DB_ID('EmpresaExamen') IS NOT NULL
BEGIN
  ALTER DATABASE EmpresaExamen SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE EmpresaExamen;
END;
GO
CREATE DATABASE EmpresaExamen;
GO
USE EmpresaExamen;
GO

/* 2) Crear schema (organización lógica) */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name=N'rrhh')
  EXEC('CREATE SCHEMA rrhh AUTHORIZATION dbo');
GO

/* 3) Limpieza defensiva por si re-ejecutás */
DROP VIEW IF EXISTS rrhh.vw_empleados_por_dep;
DROP VIEW IF EXISTS rrhh.vw_resumen_proyecto;
DROP PROCEDURE IF EXISTS rrhh.sp_asignar_empleado;
DROP TABLE IF EXISTS rrhh.Asignaciones;
DROP TABLE IF EXISTS rrhh.Proyectos;
DROP TABLE IF EXISTS rrhh.Empleados;
DROP TABLE IF EXISTS rrhh.Departamentos;
GO

/* 4) Tablas con restricciones */

/* 4.1) Departamentos (entidad fuerte) */
CREATE TABLE rrhh.Departamentos
(
  id_departamento INT IDENTITY(1,1) NOT NULL,
  nombre          VARCHAR(80)  NOT NULL,
  presupuesto     DECIMAL(12,2) NOT NULL CONSTRAINT df_dep_presupuesto DEFAULT(0),
  activo          BIT           NOT NULL CONSTRAINT df_dep_activo DEFAULT(1),
  CONSTRAINT pk_departamentos PRIMARY KEY (id_departamento),
  CONSTRAINT uq_dep_nombre UNIQUE (nombre),
  CONSTRAINT ck_dep_presupuesto CHECK (presupuesto >= 0)
);

/* 4.2) Empleados (entidad fuerte) */
CREATE TABLE rrhh.Empleados
(
  id_empleado   INT IDENTITY(1,1) NOT NULL,
  legajo        CHAR(6)     NOT NULL,         -- e.g. 000123
  apellido      VARCHAR(50) NOT NULL,
  nombre        VARCHAR(50) NOT NULL,
  dni           CHAR(8)     NOT NULL,         -- 8 dígitos
  fecha_ingreso DATE        NOT NULL,
  salario       DECIMAL(12,2) NOT NULL,
  email         VARCHAR(120) NULL,
  CONSTRAINT pk_empleados PRIMARY KEY (id_empleado),
  CONSTRAINT uq_empleados_legajo UNIQUE (legajo),
  CONSTRAINT uq_empleados_dni    UNIQUE (dni),
  CONSTRAINT ck_dni_8dig CHECK (dni NOT LIKE '%[^0-9]%' AND LEN(dni)=8),
  CONSTRAINT ck_salario_pos CHECK (salario > 0),
  CONSTRAINT ck_email_forma CHECK (email IS NULL OR email LIKE '%@%.%')
);

/* 4.3) Proyectos (lado N de 1:N con Departamentos) */
CREATE TABLE rrhh.Proyectos
(
  id_proyecto     INT IDENTITY(1,1) NOT NULL,
  nombre          VARCHAR(100) NOT NULL,
  fecha_inicio    DATE         NOT NULL,
  fecha_fin       DATE         NULL,
  id_departamento INT          NOT NULL,
  CONSTRAINT pk_proyectos PRIMARY KEY (id_proyecto),
  CONSTRAINT uq_proy_nombre UNIQUE (nombre),
  CONSTRAINT fk_proy_dep FOREIGN KEY (id_departamento)
      REFERENCES rrhh.Departamentos(id_departamento)
      ON UPDATE CASCADE
      ON DELETE NO ACTION,
  CONSTRAINT ck_fechas_proy CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

/* 4.4) Asignaciones (M:N Empleados–Proyectos) */
CREATE TABLE rrhh.Asignaciones
(
  id_empleado       INT         NOT NULL,
  id_proyecto       INT         NOT NULL,
  fecha_asignacion  DATE        NOT NULL CONSTRAINT df_asig_fecha DEFAULT(CAST(GETDATE() AS DATE)),
  rol               VARCHAR(30) NOT NULL,
  horas_semana      TINYINT     NOT NULL,   -- 1..40
  estado            VARCHAR(10) NOT NULL CONSTRAINT df_asig_estado DEFAULT('ACTIVA'), -- ACTIVA/BAJA
  CONSTRAINT pk_asignaciones PRIMARY KEY (id_empleado, id_proyecto),
  CONSTRAINT fk_asig_emp FOREIGN KEY (id_empleado)
    REFERENCES rrhh.Empleados(id_empleado)
    ON UPDATE CASCADE
    ON DELETE CASCADE,       -- si borro el empleado, borro sus asignaciones
  CONSTRAINT fk_asig_proy FOREIGN KEY (id_proyecto)
    REFERENCES rrhh.Proyectos(id_proyecto)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,
  CONSTRAINT ck_horas_rango CHECK (horas_semana BETWEEN 1 AND 40),
  CONSTRAINT ck_estado CHECK (estado IN ('ACTIVA','BAJA'))
);

/* 5) Índices útiles (físico) */
CREATE INDEX IX_Empleados_ApNom     ON rrhh.Empleados(apellido, nombre);
CREATE INDEX IX_Proy_Dep            ON rrhh.Proyectos(id_departamento);
CREATE INDEX IX_Asig_Proyecto       ON rrhh.Asignaciones(id_proyecto, estado);
GO

/* 6) Datos de ejemplo (DML) */
INSERT INTO rrhh.Departamentos (nombre, presupuesto, activo) VALUES
('Sistemas',  800000, 1),
('RRHH',      300000, 1),
('Marketing', 500000, 1);

INSERT INTO rrhh.Empleados (legajo, apellido, nombre, dni, fecha_ingreso, salario, email) VALUES
('000101','Pérez','Juan','12345678','2021-03-01', 850000,'juan.perez@empresa.com'),
('000102','Gómez','Ana','23456789','2020-07-15', 920000,'ana.gomez@empresa.com'),
('000103','López','Sofía','34567890','2022-02-10', 700000,NULL),
('000104','Martínez','Luis','45678901','2019-11-20',1100000,'luis.martinez@empresa.com');

DECLARE @depSis INT = (SELECT id_departamento FROM rrhh.Departamentos WHERE nombre='Sistemas');
DECLARE @depMkt INT = (SELECT id_departamento FROM rrhh.Departamentos WHERE nombre='Marketing');

INSERT INTO rrhh.Proyectos (nombre, fecha_inicio, fecha_fin, id_departamento) VALUES
('Intranet 2025','2025-03-01',NULL, @depSis),
('App Mobile','2025-01-10',NULL, @depSis),
('Campaña Q4','2025-08-01',NULL, @depMkt);

DECLARE @pIntra INT = (SELECT id_proyecto FROM rrhh.Proyectos WHERE nombre='Intranet 2025');
DECLARE @pApp   INT = (SELECT id_proyecto FROM rrhh.Proyectos WHERE nombre='App Mobile');
DECLARE @pCamp  INT = (SELECT id_proyecto FROM rrhh.Proyectos WHERE nombre='Campaña Q4');

DECLARE @eJuan INT = (SELECT id_empleado FROM rrhh.Empleados WHERE legajo='000101');
DECLARE @eAna  INT = (SELECT id_empleado FROM rrhh.Empleados WHERE legajo='000102');
DECLARE @eSofi INT = (SELECT id_empleado FROM rrhh.Empleados WHERE legajo='000103');
DECLARE @eLuis INT = (SELECT id_empleado FROM rrhh.Empleados WHERE legajo='000104');

INSERT INTO rrhh.Asignaciones (id_empleado, id_proyecto, rol, horas_semana, estado, fecha_asignacion) VALUES
(@eJuan, @pIntra, 'Dev',     20,'ACTIVA','2025-03-10'),
(@eAna,  @pIntra, 'PM',      10,'ACTIVA','2025-03-11'),
(@eAna,  @pApp,   'BA',      15,'ACTIVA','2025-03-11'),
(@eSofi, @pApp,   'QA',      20,'ACTIVA','2025-03-12'),
(@eLuis, @pCamp,  'SM',      10,'BAJA',  '2025-03-13');
GO

/* 7) Vistas (lógico) */
GO
CREATE OR ALTER VIEW rrhh.vw_empleados_por_dep AS
SELECT d.id_departamento, d.nombre AS departamento,
       e.id_empleado, e.apellido, e.nombre, e.legajo, e.email
FROM rrhh.Departamentos d
JOIN rrhh.Proyectos p    ON p.id_departamento = d.id_departamento
JOIN rrhh.Asignaciones a ON a.id_proyecto     = p.id_proyecto AND a.estado='ACTIVA'
JOIN rrhh.Empleados   e  ON e.id_empleado     = a.id_empleado;
GO

GO
CREATE OR ALTER VIEW rrhh.vw_resumen_proyecto AS
SELECT p.id_proyecto, p.nombre AS proyecto,
       d.nombre AS departamento,
       SUM(CASE WHEN a.estado='ACTIVA' THEN 1 ELSE 0 END) AS asignaciones_activas,
       SUM(CASE WHEN a.estado='ACTIVA' THEN a.horas_semana ELSE 0 END) AS horas_activas
FROM rrhh.Proyectos p
JOIN rrhh.Departamentos d ON d.id_departamento = p.id_departamento
LEFT JOIN rrhh.Asignaciones a ON a.id_proyecto = p.id_proyecto
GROUP BY p.id_proyecto, p.nombre, d.nombre;
GO
/* 8) Consultas DEMO para el parcial */

/* 8.1) WHERE + ORDER BY */
SELECT id_empleado, apellido, nombre, legajo, salario
FROM rrhh.Empleados
WHERE salario BETWEEN 700000 AND 1000000
ORDER BY salario DESC, apellido;

/* 8.2) JOINs: empleados con sus proyectos activos */
SELECT e.apellido, e.nombre, p.nombre AS proyecto, a.rol, a.horas_semana
FROM rrhh.Empleados e
JOIN rrhh.Asignaciones a ON a.id_empleado=e.id_empleado AND a.estado='ACTIVA'
JOIN rrhh.Proyectos p    ON p.id_proyecto=a.id_proyecto
ORDER BY e.apellido, e.nombre;

/* 8.3) GROUP BY + HAVING: proyectos con 2+ asignaciones activas */
SELECT p.nombre AS proyecto, COUNT(*) AS total_asignaciones
FROM rrhh.Proyectos p
JOIN rrhh.Asignaciones a ON a.id_proyecto=p.id_proyecto AND a.estado='ACTIVA'
GROUP BY p.nombre
HAVING COUNT(*) >= 2
ORDER BY total_asignaciones DESC;

/* 8.4) SUBCONSULTA IN: empleados con 2+ proyectos activos */
SELECT e.id_empleado, e.apellido, e.nombre
FROM rrhh.Empleados e
WHERE e.id_empleado IN (
  SELECT a.id_empleado
  FROM rrhh.Asignaciones a
  WHERE a.estado='ACTIVA'
  GROUP BY a.id_empleado
  HAVING COUNT(*) >= 2
);

/* 8.5) EXISTS: departamentos con al menos 1 proyecto activo con asignaciones */
SELECT d.id_departamento, d.nombre
FROM rrhh.Departamentos d
WHERE EXISTS (
  SELECT 1
  FROM rrhh.Proyectos p
  JOIN rrhh.Asignaciones a ON a.id_proyecto=p.id_proyecto AND a.estado='ACTIVA'
  WHERE p.id_departamento=d.id_departamento
);

/* 8.6) LEFT JOIN (para ver empleados sin asignaciones activas) */
SELECT e.id_empleado, e.apellido, e.nombre,
       COALESCE(p.nombre,'(sin proyecto)') AS proyecto
FROM rrhh.Empleados e
LEFT JOIN rrhh.Asignaciones a
  ON a.id_empleado=e.id_empleado AND a.estado='ACTIVA'
LEFT JOIN rrhh.Proyectos p
  ON p.id_proyecto=a.id_proyecto
ORDER BY proyecto DESC, e.apellido, e.nombre;

/* 9) Procedimiento almacenado con TRANSACCIÓN */
GO
CREATE OR ALTER PROCEDURE rrhh.sp_asignar_empleado
  @id_empleado INT,
  @id_proyecto INT,
  @rol         VARCHAR(30),
  @horas       TINYINT
AS
BEGIN
  SET NOCOUNT ON;
  BEGIN TRY
    BEGIN TRAN;

    IF @horas NOT BETWEEN 1 AND 40
      THROW 60001, 'Horas fuera de rango (1-40).', 1;

    IF EXISTS (SELECT 1 FROM rrhh.Asignaciones 
               WHERE id_empleado=@id_empleado AND id_proyecto=@id_proyecto AND estado='ACTIVA')
      THROW 60002, 'El empleado ya está asignado activamente a ese proyecto.', 1;

    DECLARE @horasActuales INT =
      (SELECT COALESCE(SUM(horas_semana),0)
       FROM rrhh.Asignaciones
       WHERE id_empleado=@id_empleado AND estado='ACTIVA');

    IF @horasActuales + @horas > 40
      THROW 60003, 'No se puede asignar: excede 40 hs/semana.', 1;

    INSERT INTO rrhh.Asignaciones (id_empleado, id_proyecto, rol, horas_semana, estado)
    VALUES (@id_empleado, @id_proyecto, @rol, @horas, 'ACTIVA');

    COMMIT;
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    DECLARE @msg NVARCHAR(4000) = CONCAT('ERROR ',ERROR_NUMBER(),': ',ERROR_MESSAGE());
    RAISERROR(@msg, 16, 1);
  END CATCH
END;
GO

/* 10) Chequeos finales (ejecutá esto después de que creen las vistas) */
SELECT TOP (100) * FROM rrhh.vw_empleados_por_dep ORDER BY departamento, apellido, nombre;
SELECT TOP (100) * FROM rrhh.vw_resumen_proyecto   ORDER BY horas_activas DESC, proyecto;