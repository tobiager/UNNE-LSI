CREATE DATABASE practica_primer_parcial_2025;
GO
USE practica_primer_parcial_2025;
GO

/*========================
  CATALOGOS (tipificación)
  ========================*/
CREATE TABLE roles (
  rol_id      INT NOT NULL,
  nombre      VARCHAR(50) NOT NULL,
  CONSTRAINT PK_roles PRIMARY KEY (rol_id),
  CONSTRAINT UQ_roles_nombre UNIQUE (nombre)
);
GO

CREATE TABLE estados_tarea (
  estado_id   INT NOT NULL,
  nombre      VARCHAR(30) NOT NULL,
  CONSTRAINT PK_estados_tarea PRIMARY KEY (estado_id),
  CONSTRAINT UQ_estados_tarea_nombre UNIQUE (nombre)
);
GO

/*========================
  EMPLEADOS Y PROYECTOS
  ========================*/
CREATE TABLE empleados (
  empleado_id  INT NOT NULL,
  nombre       VARCHAR(100) NOT NULL,
  correo       VARCHAR(100) NOT NULL,
  CONSTRAINT PK_empleados PRIMARY KEY (empleado_id),
  CONSTRAINT UQ_empleados_correo UNIQUE (correo)
);
GO

CREATE TABLE proyectos (
  proyecto_id   INT NOT NULL,
  nombre        VARCHAR(120) NOT NULL,
  fecha_inicio  DATE NOT NULL,
  fecha_fin     DATE NULL,
  CONSTRAINT PK_proyectos PRIMARY KEY (proyecto_id),
  CONSTRAINT UQ_proyectos_nombre UNIQUE (nombre),
  CONSTRAINT CK_proyectos_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);
GO

/*========================
  ASIGNACIONES (M:N con rol)
  ========================*/
CREATE TABLE asignaciones (
  proyecto_id    INT NOT NULL,
  empleado_id    INT NOT NULL,
  rol_id         INT NOT NULL,
  fecha_inicio   DATE NOT NULL,
  fecha_fin      DATE NULL,
  CONSTRAINT PK_asignaciones PRIMARY KEY (proyecto_id, empleado_id),
  CONSTRAINT FK_asig_proyectos  FOREIGN KEY (proyecto_id) REFERENCES proyectos(proyecto_id),
  CONSTRAINT FK_asig_empleados  FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id),
  CONSTRAINT FK_asig_roles      FOREIGN KEY (rol_id)      REFERENCES roles(rol_id),
  CONSTRAINT CK_asig_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);
GO

/*========================
  TAREAS (1:N dentro de proyecto)
  ========================*/
CREATE TABLE tareas (
  tarea_id        INT NOT NULL,
  proyecto_id     INT NOT NULL,
  orden           INT NOT NULL,         
  descripcion     VARCHAR(300) NOT NULL,
  fecha_inicio    DATE NOT NULL,
  fecha_fin       DATE NULL,
  estado_id       INT NOT NULL,
  CONSTRAINT PK_tareas PRIMARY KEY (tarea_id),
  CONSTRAINT FK_tareas_proyectos FOREIGN KEY (proyecto_id) REFERENCES proyectos(proyecto_id),
  CONSTRAINT FK_tareas_estado FOREIGN KEY (estado_id)   REFERENCES estados_tarea(estado_id),
  CONSTRAINT UQ_tareas_orden_x_proy UNIQUE (proyecto_id, orden),
  CONSTRAINT CK_tareas_orden_pos CHECK (orden > 0),
  CONSTRAINT CK_tareas_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);
GO

/*========================
  DEFAULTS (opcional)
  ========================*/
-- Estados por defecto y DF en tareas -> 'pendiente'
INSERT INTO estados_tarea (estado_id, nombre) VALUES (1,'pendiente'), (2,'en_progreso'), (3,'finalizada');
GO
ALTER TABLE tareas
  ADD CONSTRAINT DF_tareas_estado DEFAULT (1) FOR estado_id;
GO

-- Algunos roles base (puede ampliarse)
INSERT INTO roles (rol_id, nombre)
VALUES (1,'director_proyecto'),
       (2,'analista_funcional'),
       (3,'desarrollador'),
       (4,'tester'),
       (5,'disenador');
GO
