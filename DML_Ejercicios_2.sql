CREATE TABLE CLIENTES (
    codigo_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    domicilio VARCHAR(100),
    provincia VARCHAR(50)
);

CREATE TABLE PRODUCTOS (
    codigo_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100)
);

CREATE TABLE ITEM_VENTAS (
    numero_factura INT,
    codigo_producto INT,
    cantidad INT,
    precio DECIMAL(10, 2),
    PRIMARY KEY (numero_factura, codigo_producto),
    FOREIGN KEY (codigo_producto) REFERENCES PRODUCTOS(codigo_producto)
);

CREATE TABLE VENTAS (
    numero_factura INT PRIMARY KEY,
    codigo_cliente INT,
    fecha DATE,
    FOREIGN KEY (codigo_cliente) REFERENCES CLIENTES(codigo_cliente)
);
