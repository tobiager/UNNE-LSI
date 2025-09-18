/* =======================
   Machete SQL – Restricciones
   ======================= */

/* PRIMARY KEY */
id INT PRIMARY KEY,

/* FOREIGN KEY */
FOREIGN KEY (cliente_id) REFERENCES Cliente(id_cliente),

/* NOT NULL */
nombre VARCHAR(50) NOT NULL,

/* UNIQUE */
correo VARCHAR(50) UNIQUE,

/* DEFAULT */
fecha_publicacion DATE NOT NULL DEFAULT GETDATE(),


/* CHECKS */

/* Edad mínima 18 */
fecha_nacimiento DATE CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) >= 18),

/* Total positivo */
total DECIMAL(12,2) CHECK (total >= 0),

/* Cantidad y precio mayores a 0 */
cantidad INT CHECK (cantidad > 0),
precio DECIMAL(12,2) CHECK (precio > 0),

/* Calificación 1 a 10 */
calificacion TINYINT CHECK (calificacion BETWEEN 1 AND 10),

/* Porcentajes en rango válido */
porcentaje TINYINT CHECK (porcentaje BETWEEN 0 AND 100),

/* Estado limitado */
estado VARCHAR(20) CHECK (estado IN ('activa','pausada')),

/* Fechas coherentes */
fecha_inicio DATE,
fecha_fin DATE,
CHECK (fecha_inicio <= fecha_fin),

/* No permitir fechas futuras (nacimiento/ingreso/etc.) */
fecha DATE CHECK (fecha <= CAST(GETDATE() AS DATE)),

/* DNI numérico de 8 dígitos */
dni VARCHAR(8) CHECK (LEN(dni) = 8 AND dni NOT LIKE '%[^0-9]%'),

/* CUIT numérico de 11 dígitos */
cuit VARCHAR(11) CHECK (LEN(cuit) = 11 AND cuit NOT LIKE '%[^0-9]%'),

/* Formato de email (chequeo simple) */
email VARCHAR(120) CHECK (email LIKE '%_@_%._%'),

/* Rol limitado a opciones válidas */
rol VARCHAR(30) CHECK (rol IN ('Director de Proyecto','Analista Funcional','Desarrollador','Tester','Diseñador')),

/* Fechas coherentes en participación */
CHECK (fecha_fin IS NULL OR fecha_inicio <= fecha_fin),

/* Estado de tarea limitado */
estado VARCHAR(20) CHECK (estado IN ('Pendiente','En progreso','Finalizada')),

/* Fechas coherentes en tarea */
CHECK (fecha_fin IS NULL OR fecha_inicio <= fecha_fin)


/* DEFAULTS */

/* Fecha actual por defecto */
fecha DATE DEFAULT GETDATE(),

/* Estado inicial */
estado VARCHAR(20) DEFAULT 'activo'
