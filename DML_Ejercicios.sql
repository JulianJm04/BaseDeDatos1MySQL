-- Insertar datos en PROVEEDORES
INSERT INTO PROVEEDORES (NUMERO, NOMBRE, DOMICILIO, LOCALIDAD) VALUES
(101, 'Gómez', 'Nazca 920', 'Capital Federal'),
(102, 'Pérez', 'Argerich 1030', 'Capital Federal'),
(103, 'Vázquez', 'Sarmiento 450', 'Ramos Mejía'),
(104, 'López', 'Alsina 720', 'Avellaneda');

-- Insertar datos en PRODUCTOS
INSERT INTO PRODUCTOS (PNRO, PNOMBRE, PRECIO, TAMAÑO, LOCALIDAD) VALUES
(1, 'Talco', 500, 'Chico', 'Capital Federal'),
(2, 'Crema', 3500, 'Grande', 'Ramos Mejía'),
(3, 'Cepillo', 2500, 'Grande', 'Avellaneda');

-- Insertar datos en PROV_PROD
INSERT INTO PROV_PROD (NUMERO, PNRO, CANTIDAD) VALUES
(101, 1, 300),
(102, 2, 200),
(103, 3, 150);

-- Ejercicio 1 (DML):
-- Obtener los detalles completos de todos los productos.
SELECT * 
FROM PRODUCTOS;


-- Ejercicio 2 (DML):
-- Obtener los detalles completos de todos los proveedores de Capital.
SELECT * 
FROM PROVEEDORES 
WHERE LOCALIDAD = 'Capital';


-- Ejercicio 3 (DML):
-- Obtener todos los envíos en los cuales la cantidad está entre 200 y 300 inclusive.
SELECT * 
FROM PROV_PROD 
WHERE CANTIDAD BETWEEN 200 AND 300;


-- Ejercicio 4 (DML):
-- Obtener los números de los productos suministrados por algún proveedor de Avellaneda.
SELECT PNRO 
FROM PROV_PROD 
WHERE NUMERO IN 
    (SELECT NUMERO 
     FROM PROVEEDORES 
     WHERE LOCALIDAD = 'Avellaneda');


-- Ejercicio 5 (DMDL):
-- Obtener la cantidad total del producto 001 enviado por el proveedor 103.
SELECT SUM(CANTIDAD) 
FROM PROV_PROD 
WHERE PNRO = 1 AND NUMERO = 103;


-- Ejercicio 6 (DML):
-- Obtener los números de los productos y localidades en los cuales la segunda letra del nombre de la 
-- localidad sea A.
SELECT PNRO, LOCALIDAD 
FROM PRODUCTOS 
WHERE LOCALIDAD LIKE '_A%';


-- Ejercicio 7 (DML):
-- Obtener los precios de los productos enviados por el proveedor 102.
SELECT P.PRECIO 
FROM PRODUCTOS P
JOIN PROV_PROD PP ON P.PNRO = PP.PNRO
WHERE PP.NUMERO = 102;


-- Ejercicio 8 (DML):
-- Construir una lista de todas las localidades en las cuales esté situado por lo menos un proveedor o un 
-- producto.
SELECT LOCALIDAD 
FROM PROVEEDORES
UNION
SELECT LOCALIDAD 
FROM PRODUCTOS;


-- Ejercicio 9 (DML):
-- Cambiar a “Chico” el tamaño de todos los productos medianos.
UPDATE PRODUCTOS 
SET TAMAÑO = 'Chico' 
WHERE TAMAÑO = 'Mediano';


-- Ejercicio 10 (DML):
-- Eliminar todos lo sproductos para los cuales no haya envíos.
DELETE FROM PRODUCTOS 
WHERE PNRO NOT IN 
    (SELECT PNRO 
     FROM PROV_PROD);


-- Ejercicio 11 (DML):
-- Insertar un nuevo proveedor (107) en la tabla PROVEEDORES. El nombre y la localidad son Rosales y 
-- Wilde respectivamente; el domicilio no se conoce todavía
INSERT INTO PROVEEDORES (NUMERO, NOMBRE, LOCALIDAD) 
VALUES (107, 'Rosales', 'Wilde');
