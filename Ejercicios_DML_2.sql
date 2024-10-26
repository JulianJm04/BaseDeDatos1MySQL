-- EJERCICIOS DE DML 2:

-- Crear tabla de clientes.
CREATE TABLE CLIENTES (
    codigo_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    domicilio VARCHAR(100),
    provincia VARCHAR(50)
);

-- Crear tabla de productos.
CREATE TABLE PRODUCTOS (
    codigo_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100)
);

-- Crear tabla de item de ventas
CREATE TABLE ITEM_VENTAS (
    numero_factura INT,
    codigo_producto INT,
    cantidad INT,
    precio DECIMAL(10, 2),
    PRIMARY KEY (numero_factura, codigo_producto),
    FOREIGN KEY (codigo_producto) REFERENCES PRODUCTOS(codigo_producto)
);

-- Crear tabla de ventas
CREATE TABLE VENTAS (
    numero_factura INT PRIMARY KEY,
    codigo_cliente INT,
    fecha DATE,
    FOREIGN KEY (codigo_cliente) REFERENCES CLIENTES(codigo_cliente)
);

INSERT INTO CLIENTES (codigo_cliente, nombre, domicilio, provincia) VALUES
(1, 'Juan Pérez', 'Calle Falsa 123', 'Buenos Aires'),
(2, 'Ana López', 'Av. Siempreviva 456', 'Córdoba'),
(3, 'Carlos Gómez', 'Calle Real 789', 'Mendoza');

INSERT INTO PRODUCTOS (codigo_producto, nombre_producto) VALUES
(101, 'Producto A'),
(102, 'Producto B'),
(103, 'Producto C');

INSERT INTO VENTAS (numero_factura, codigo_cliente, fecha) VALUES
(1001, 1, '2024-09-01'),
(1002, 2, '2024-09-02'),
(1003, 3, '2024-09-03'),
(1004, 1, '2024-09-04');

INSERT INTO ITEM_VENTAS (numero_factura, codigo_producto, cantidad, precio) VALUES
(1001, 101, 10, 100.00),
(1001, 102, 5, 200.00),
(1002, 103, 2, 300.00),
(1003, 101, 4, 100.00),
(1003, 102, 1, 200.00),
(1004, 103, 3, 300.00);


-- Ejercicio 1 (DML):
-- Obtener la cantidad de unidades máxima.
SELECT MAX(cantidad) AS cantidad_maxima
FROM ITEM_VENTAS;


-- Ejercicio 2 (DML):
-- Obtener la cantidad total de unidades vendidas del producto c.
SELECT SUM(IV.cantidad) AS total_unidades_vendidas
FROM ITEM_VENTAS IV
JOIN PRODUCTOS P ON IV.codigo_producto = P.codigo_producto
WHERE P.nombre_producto = 'Producto C';


-- Ejercicio 3 (DML):
--  Cantidad de unidades vendidas por producto, indicando la descripción del producto, ordenado de 
-- mayor a menor por las cantidades vendidas. 
SELECT P.nombre_producto, SUM(IV.cantidad) AS total_unidades_vendidas
FROM ITEM_VENTAS IV
JOIN PRODUCTOS P ON IV.codigo_producto = P.codigo_producto
GROUP BY P.nombre_producto
ORDER BY total_unidades_vendidas DESC;


-- Ejercicio 4 (DML):
-- Cantidad de unidades vendidas por producto, indicando la descripción del producto, ordenado 
-- alfabéticamente por nombre de producto para los productos que vendieron más de 30 unidades. 
SELECT P.nombre_producto, SUM(IV.cantidad) AS total_unidades_vendidas
FROM ITEM_VENTAS IV
JOIN PRODUCTOS P ON IV.codigo_producto = P.codigo_producto
GROUP BY P.nombre_producto
HAVING SUM(IV.cantidad) > 30
ORDER BY P.nombre_producto ASC;


-- Ejercicio 5 (DML):
-- Obtener cuantas compras (1 factura = 1 compra) realizó cada cliente indicando el código y nombre del 
-- cliente ordenado de mayor a menor. 
SELECT C.codigo_cliente, C.nombre, COUNT(V.numero_factura) AS total_compras
FROM CLIENTES C
JOIN VENTAS V ON C.codigo_cliente = V.codigo_cliente
GROUP BY C.codigo_cliente, C.nombre
ORDER BY total_compras DESC;


-- Ejercicio 6 (DML):
-- Promedio de unidades vendidas por producto, indicando el código del producto para el cliente 1.
SELECT IV.codigo_producto, AVG(IV.cantidad) AS promedio_unidades_vendidas
FROM ITEM_VENTAS IV
JOIN VENTAS V ON IV.numero_factura = V.numero_factura
WHERE V.codigo_cliente = 1
GROUP BY IV.codigo_producto;