/* Tabla 'inmueble'
Cada registro de la tabla inmueble representa a un departamento perteneciente a un edificio.
Cada edificio puede tener inmuebles (departamentos) asignados o no. Pueden existir inmuebles que todavía no fueron asignados a un edificio.
Cada inmueble pertenece solo a un edificio.
En cada edificio, los inmuebles (deartamentos) se distribuyen en pisos, siendo '0': Planta baja, '1' 1er piso, etc.
Cada departamento dentro de un piso, se identifica con una letra A, B, C, ...
Un departamento, puede estar ubicado en el frente del edificio, asume el valor 1 en caso afirmativo
Un departamento, puede tener balcón, asume el valor 1 en caso afirmativo

*/

-- DROP TABLE inmueble;
CREATE TABLE inmueble(
	 inmueble_id  INT NOT NULL,
	 nro_piso INT NOT NULL, -- número del piso. 0 para planta baja
	 dpto Varchar(1) NOT NULL, -- letra que identifica al departamento en cada piso
	 sup_cubierta DECIMAL(6,2), -- superficie en m2 del departamento
	 frente bit, --  asume el valor 1 en caso de que esté en el frente
	 balcon bit, -- asume el valor 1 en caso de que tenga balcón
     provincia_id INT NULL,
	 localidad_id INT NULL,
	 edificio_id INT NULL
 );


ALTER TABLE inmueble
	ADD CONSTRAINT PK_inmueble PRIMARY KEY (inmueble_id); 

ALTER TABLE inmueble
	ADD CONSTRAINT FK_inmueble_edificio FOREIGN KEY(provincia_id, localidad_id, edificio_id)
	REFERENCES edificio(provincia_id, localidad_id, edificio_id);


