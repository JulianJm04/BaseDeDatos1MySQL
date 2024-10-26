-- EJERCICIOS DE DDL:

-- Crear tabla la tabla de proveedores.
CREATE TABLE PROVEEDORES
(
    NUMERO INT NOT NULL,
    NOMBRE VARCHAR(20) NOT NULL,
    DOMICILIO VARCHAR(30) NOT NULL,
    LOCALIDAD VARCHAR(30),
    PRIMARY KEY (NUMERO)
);

-- Crear la tabla de productos.
CREATE TABLE PRODUCTOS
(
    PNRO INT NOT NULL,
    PNOMBRE VARCHAR(20) NOT NULL,
    PRECIO INT NOT NULL,
    TAMAÑO VARCHAR(20),
    LOCALIDAD VARCHAR(30) NOT NULL,
    PRIMARY KEY (PNRO)
);

-- Crear la tabla PROV_PROD.
CREATE TABLE PROV_PROD
(
    NUMERO INT NOT NULL,
    PNRO INT NOT NULL,
    CANTIDAD INT NOT NULL,
    PRIMARY KEY (NUMERO, PNRO),
    FOREIGN KEY (NUMERO) REFERENCES PROVEEDORES (NUMERO),
    FOREIGN KEY (PNRO) REFERENCES PRODUCTOS (PNRO)
);

-- Insertar datos en PROVEEDORES
INSERT INTO PROVEEDORES (NUMERO, NOMBRE, DOMICILIO, LOCALIDAD) VALUES
(101, 'Gómez', 'Nazca 920', 'Capital Federal'),
(102, 'Pérez', 'Argerich 1030', 'Capital Federal'),
(103, 'Vázquez', 'Sarmiento 450', 'Ramos Mejía'),
(104, 'López', 'Alsina 720', 'Avellaneda'),
(105, 'Diaz', 'Alsina 123', 'Wilde');

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

-- Ejercicio 1 (DDL):
-- Crear una vista formada por los números de proveedores y números de productos situados en 
-- diferentes localidades.
CREATE VIEW Vista_Proveedores_Productos_Diferentes_Localidades AS
SELECT 
    P.NUMERO AS Numero_Proveedor, 
    P.NOMBRE AS Nombre_Proveedor, 
    PR.PNRO AS Numero_Producto, 
    PR.PNOMBRE AS Nombre_Producto, 
    PR.LOCALIDAD AS Localidad_Producto
FROM 
    PROVEEDORES P
JOIN 
    PROV_PROD PP ON P.NUMERO = PP.NUMERO
JOIN 
    PRODUCTOS PR ON PP.PNRO = PR.PNRO
WHERE 
    P.LOCALIDAD <> PR.LOCALIDAD;


-- Ejercicio 2 (DDL):
-- Agregar la columna IMPORTADOR a la tabla PRODUCTOS.
ALTER TABLE PRODUCTOS
ADD COLUMN IMPORTADOR VARCHAR(50);


-- Ejercicio 3 (DDL):
-- Crear una vista formada por los registros de los proveedores que viven en Wilde.
CREATE VIEW Vista_Proveedores_Wilde AS
SELECT 
    NUMERO, 
    NOMBRE, 
    LOCALIDAD
FROM 
    PROVEEDORES
WHERE 
    LOCALIDAD = 'Wilde';


-- Ejercicio 4 (DDL):
-- Crear las tablas DEPARTAMENTOS y EMPLEADOS con sus relaciones, y las tablas PACIENTES y 
-- MEDICAMENTOS con sus relaciones.
-- Crear la tabla de departamentos:
CREATE TABLE DEPARTAMENTOS
(
    ID_DEPARTAMENTO INT NOT NULL,
    NOMBRE VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID_DEPARTAMENTO)
);

-- Crear la tabla de empleados:
CREATE TABLE EMPLEADOS
(
    ID_EMPLEADO INT NOT NULL,
    NOMBRE VARCHAR(50) NOT NULL,
    APELLIDO VARCHAR(50) NOT NULL,
    ID_DEPARTAMENTO INT,
    PRIMARY KEY (ID_EMPLEADO),
    FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES DEPARTAMENTOS(ID_DEPARTAMENTO)
);
-- Crear la tabla de pacientes:
CREATE TABLE PACIENTES
(
    CODIGO_PAC INT NOT NULL,
    APELLIDO_PAC VARCHAR(50) NOT NULL,
    EDAD INT,
    PRIMARY KEY (CODIGO_PAC)
);

-- Crear la tabla de medicamentos:
CREATE TABLE MEDICAMENTOS
(
    CODIGO_MED INT NOT NULL,
    PRECIO_UNITARIO DECIMAL(10, 2),
    PRIMARY KEY (CODIGO_MED)
);

-- Crear la tabla de gastos
CREATE TABLE GASTOS
(
    CODIGO_PAC INT,
    CODIGO_MED INT,
    PRIMARY KEY (CODIGO_PAC, CODIGO_MED),
    FOREIGN KEY (CODIGO_PAC) REFERENCES PACIENTES(CODIGO_PAC),
    FOREIGN KEY (CODIGO_MED) REFERENCES MEDICAMENTOS(CODIGO_MED)
);