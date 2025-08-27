Create table Empleados
(
Dni int Primary Key,
Legajo Char(6) Unique,
Ape_y_Nom Varchar(60),
Cargo Int Check(cargo between 50 and 120),
Sueldo Dec(8,2) Check(sueldo <= 90000)
);


INSERT INTO Empleados
VALUES (41015736,54208,'Juan Caceres', 50, 90000)


CREATE DOMAIN Documento as int CHECK(value>0)


ALTER TABLE Empleados
ALTER COLUMN dni TYPE Documento


INSERT INTO Empleados
VALUES (-1,54209,'Abril Barril', 50, 90000) -- da error
INSERT INTO Empleados
VALUES (41606944,54209,'Abril Barril', 50, 90000)


CREATE OR REPLACE TRIGGER Control_sueldo
	BEFORE UPDATE OF sueldo ON empleados
	FOR EACH ROW
	EXECUTE PROCEDURE Control_sueldo();
	
CREATE OR REPLACE FUNCTION Control_sueldo() RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.sueldo > (OLD.sueldo * 1.20)) THEN
		RAISE EXCEPTION 'El sueldo no puede aumentar en mas del 20 porciento.';
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


UPDATE Empleados
SET sueldo=10000
WHERE dni=41606944 -- da error



Create table Importes_basicos
(
cargo int Primary Key,
importe_basico int
);

INSERT INTO Importes_basicos
VALUES (90,10000)

CREATE OR REPLACE TRIGGER Adicional_cargo
AFTER INSERT OR UPDATE OF cargo ON Empleados
FOR EACH ROW
EXECUTE PROCEDURE Adicional_cargo();

CREATE OR REPLACE FUNCTION Adicional_cargo() RETURNS TRIGGER AS $$
BEGIN
	IF(new.cargo = 90) THEN
		UPDATE Empleados
		SET sueldo = sueldo + ((SELECT importe_basico FROM Importes_basicos WHERE cargo = new.cargo) * 0.15)
		WHERE dni=new.dni;
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;

UPDATE Empleados
SET cargo=90
WHERE dni=41015736

INSERT INTO Empleados
VALUES (41020300,54211,'asd 123', 90, 20000)

SELECT * FROM Empleados

---------------------------------------------
-- PUNTO 2
