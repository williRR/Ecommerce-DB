-- Crear la base de datos
CREATE DATABASE DW_abarroteria;
GO

-- Seleccionar la base de datos
USE DW_abarroteria;
GO

-- Crear las tablas de dimensiones primero

CREATE TABLE dim_cliente (
    nit_cliente VARCHAR(14) PRIMARY KEY,
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    correo_electronico VARCHAR(50),
    telefono VARCHAR(10),
    nacimiento DATE,
    genero CHAR(1) CHECK(genero IN ('m', 'f')),
    direccion VARCHAR(50)
);
GO

CREATE TABLE dim_producto (
    codigo_producto VARCHAR(14) PRIMARY KEY,
    nombre_producto VARCHAR(50),
    marca VARCHAR(20),
    fecha_vencimiento DATE,
    precio_unitario DECIMAL(10,2)
);
GO

CREATE TABLE dim_empleado (
    codigo_empleado VARCHAR(14) PRIMARY KEY,
    nombre_completo VARCHAR(100),
    dni VARCHAR(16),
    correo_electronico VARCHAR(50),
    telefono VARCHAR(10),
    fecha_alta DATE,
    fecha_baja DATE
);
GO

CREATE TABLE dim_empresa (
    nit_empresa VARCHAR(14) PRIMARY KEY,
    nombre_comercial VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(10),
    correo_electronico VARCHAR(50),
    estado CHAR(1) CHECK(estado IN ('a', 'n'))
);
GO

CREATE TABLE dim_fecha (
    fecha DATE PRIMARY KEY,
    dia INT,
    mes INT,
    anio INT,
    trimestre INT
);
GO

-- Crear la tabla de hechos después de las tablas de dimensiones
CREATE TABLE hechos_ventas (
    id_venta INT PRIMARY KEY IDENTITY(1,1),
    fk_no_factura VARCHAR(50),
    fk_cliente VARCHAR(14),
    fk_producto VARCHAR(14),
    fk_empleado VARCHAR(14),
    fk_empresa VARCHAR(14),
    cantidad INT NOT NULL CHECK(cantidad >= 1),
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (fk_cliente) REFERENCES dim_cliente(nit_cliente),
    FOREIGN KEY (fk_producto) REFERENCES dim_producto(codigo_producto),
    FOREIGN KEY (fk_empleado) REFERENCES dim_empleado(codigo_empleado),
    FOREIGN KEY (fk_empresa) REFERENCES dim_empresa(nit_empresa)
);
GO
