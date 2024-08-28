

CREATE DATABASE abarroteria;
GO
USE abarroteria;
GO

DROP TABLE IF EXISTS venta_detalle;
DROP TABLE IF EXISTS venta;
DROP TABLE IF EXISTS compra_detalle;
DROP TABLE IF EXISTS compra;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS inventario;
DROP TABLE IF EXISTS proveedor;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS empresa;
DROP TABLE IF EXISTS presentacion;
DROP TABLE IF EXISTS modificacion;
GO

-- Crear la tabla de presentacion
CREATE TABLE presentacion (
    correlativo INT PRIMARY KEY IDENTITY(1,1),
    capacidad VARCHAR(10) NOT NULL,
    unidad_envase VARCHAR(10) NOT NULL,
    descripcion VARCHAR(50) NOT NULL
);
GO

-- Crear la tabla de proveedor
CREATE TABLE proveedor (
    codigo_proveedor VARCHAR(14) PRIMARY KEY,
    nombre_empresa VARCHAR(30) NOT NULL,
    primer_nombre VARCHAR(20) NOT NULL,
    segundo_nombre VARCHAR(20) NULL,
    primer_apellido VARCHAR(20) NOT NULL,
    segundo_apellido VARCHAR(20) NOT NULL,
    fecha_comienzo_relacion DATE NULL,
    correo_electronico VARCHAR(50) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    telefono_fijo VARCHAR(10) NULL,
    departamento VARCHAR(30) NOT NULL,
    municipio VARCHAR(25) NOT NULL,
    zona VARCHAR(25) NULL,
    calle VARCHAR(25) NULL,
    avenida VARCHAR(25) NULL,
    creacion DATETIME DEFAULT GETDATE() NOT NULL,
    usuario VARCHAR(50) NULL DEFAULT SUSER_SNAME() ,
    fecha_modificacion DATETIME  NULL DEFAULT GETDATE(),
    estado CHAR(1) CHECK(estado IN ('a', 'n')) DEFAULT 'a'
);
GO

-- Crear la tabla de inventario
CREATE TABLE inventario (
    codigo_inventario VARCHAR(14) PRIMARY KEY,
    fk_proveedor VARCHAR(14),
    cantidad_disponible INT NOT NULL CHECK(cantidad_disponible >= 1),
    precio_compra DECIMAL(10,2) NOT NULL CHECK(precio_compra >= 1),
    fecha_abastecimiento DATE NOT NULL,
    ubicacion VARCHAR(20) NOT NULL,
    creacion DATETIME DEFAULT GETDATE() NOT NULL,
    usuario VARCHAR(50) NULL DEFAULT SUSER_SNAME() ,
    fecha_modificacion DATETIME  NULL DEFAULT GETDATE(),
    estado CHAR(1) CHECK(estado IN ('a', 'n')) DEFAULT 'a',

    CONSTRAINT fk_inventario_proveedor FOREIGN KEY (fk_proveedor) REFERENCES proveedor(codigo_proveedor)
);
GO

-- Crear la tabla de producto
CREATE TABLE producto (
    codigo_producto VARCHAR(14) PRIMARY KEY,
    fk_inventario VARCHAR(14),
    fk_presentacion INT,
    precio_unitario DECIMAL(10,2) NOT NULL CHECK(precio_unitario > 0),
    fecha_entrada DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    marca VARCHAR(20) NULL,
    creacion DATETIME DEFAULT GETDATE() NOT NULL,
    usuario VARCHAR(50) NULL DEFAULT SUSER_SNAME() ,
    fecha_modificacion DATETIME  NULL DEFAULT GETDATE(),
    estado CHAR(1) CHECK(estado IN ('a', 'n')) DEFAULT 'a',

    CONSTRAINT fk_producto_inventario FOREIGN KEY (fk_inventario) REFERENCES inventario(codigo_inventario),
    CONSTRAINT fk_producto_presentacion FOREIGN KEY (fk_presentacion) REFERENCES presentacion(correlativo)
);
GO

-- Crear la tabla de empresa
CREATE TABLE empresa (
    nit VARCHAR(14) PRIMARY KEY,
    nombre_comercial VARCHAR(50) NOT NULL,
    departamento VARCHAR(30) NOT NULL,
    municipio VARCHAR(25) NOT NULL,
    zona VARCHAR(25) NULL,
    calle VARCHAR(25) NULL,
    avenida VARCHAR(25) NULL,
    telefono VARCHAR(10) NOT NULL,
    correo_electronico VARCHAR(50) NOT NULL,
    creacion DATETIME DEFAULT GETDATE() NOT NULL,
    usuario VARCHAR(50) NULL DEFAULT SUSER_SNAME() ,
    fecha_modificacion DATETIME  NULL DEFAULT GETDATE(),
    estado CHAR(1) CHECK(estado IN ('a', 'n')) DEFAULT 'a'
);
GO

-- Crear la tabla de cliente
CREATE TABLE cliente (
    nit VARCHAR(14) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    correo_electronico VARCHAR(50) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    nacimiento DATE NOT NULL,
    genero CHAR(1) CHECK(genero IN ('m', 'f')) NOT NULL,
    direccion VARCHAR(50),
    creacion DATETIME DEFAULT GETDATE() NOT NULL,
    usuario VARCHAR(50) NULL DEFAULT SUSER_SNAME() ,
    fecha_modificacion DATETIME  NULL DEFAULT GETDATE(),
    estado CHAR(1) CHECK(estado IN ('a', 'n')) DEFAULT 'a'
);
GO

-- Crear la tabla de empleado
CREATE TABLE empleado (
    codigo_empleado VARCHAR(14) PRIMARY KEY,
    dni VARCHAR(16) NOT NULL,
    primer_nombre VARCHAR(20) NOT NULL,
    segundo_nombre VARCHAR(20) NULL,
    tercer_nombre VARCHAR(20) NULL,
    primer_apellido VARCHAR(20) NOT NULL,
    segundo_apellido VARCHAR(20) NOT NULL,
    apellido_casada VARCHAR(20) NULL,
    direccion VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(50) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    fecha_alta DATE NOT NULL,
    fecha_baja DATE NULL,
    genero CHAR(1) CHECK(genero IN ('m', 'f')) NOT NULL,
    nacimiento DATE NOT NULL,
    creacion DATETIME DEFAULT GETDATE() NOT NULL,
    usuario VARCHAR(50) NULL DEFAULT SUSER_SNAME() ,
    fecha_modificacion DATETIME  NULL DEFAULT GETDATE(),
    estado CHAR(1) CHECK(estado IN ('a', 'n')) DEFAULT 'a'
);
GO

-- Crear la tabla de venta
CREATE TABLE venta (
    no_factura VARCHAR(50) PRIMARY KEY,
    fk_nit_cliente VARCHAR(14),
    fk_empresa VARCHAR(14),
    fk_empleado VARCHAR(14),
    fecha DATE NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL DEFAULT(0.01),

    CONSTRAINT fk_venta_nit_cliente FOREIGN KEY (fk_nit_cliente) REFERENCES cliente(nit),
    CONSTRAINT fk_venta_empresa FOREIGN KEY (fk_empresa) REFERENCES empresa(nit),
    CONSTRAINT fk_venta_empleado FOREIGN KEY (fk_empleado) REFERENCES empleado(codigo_empleado)
);
GO

-- Crear la tabla de venta_detalle
CREATE TABLE venta_detalle (
    codigo_detalle VARCHAR(50) PRIMARY KEY,
    fk_no_factura VARCHAR(50),
    fk_codigo_producto VARCHAR(14),
    nombre_producto VARCHAR(50) NOT NULL,
    cantidad INT CHECK(cantidad >= 1) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_venta_detalle_no_factura FOREIGN KEY (fk_no_factura) REFERENCES venta(no_factura),
    CONSTRAINT fk_venta_detalle_codigo_producto FOREIGN KEY (fk_codigo_producto) REFERENCES producto(codigo_producto)
);
GO

-- Crear la tabla de compra
CREATE TABLE compra (
    no_factura VARCHAR(50) PRIMARY KEY,
    fk_empresa VARCHAR(14),
    fk_proveedor VARCHAR(14),
    fecha DATE NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL DEFAULT(0.01),

    CONSTRAINT fk_compra_proveedor FOREIGN KEY (fk_proveedor) REFERENCES proveedor(codigo_proveedor),
    CONSTRAINT fk_compra_empresa FOREIGN KEY (fk_empresa) REFERENCES empresa(nit)
);
GO

-- Crear la tabla de compra_detalle
CREATE TABLE compra_detalle (
    codigo_detalle VARCHAR(50) PRIMARY KEY,
    fk_no_factura VARCHAR(50),
    fk_codigo_producto VARCHAR(14),
    nombre_producto VARCHAR(50) NULL,
    cantidad INT CHECK(cantidad >= 1) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_compra_detalle_no_factura FOREIGN KEY (fk_no_factura) REFERENCES compra(no_factura),
    CONSTRAINT fk_compra_detalle_codigo_producto FOREIGN KEY (fk_codigo_producto) REFERENCES producto(codigo_producto)
);
GO

-- Crear la tabla de modificacion
CREATE TABLE modificacion (
    correlativo INT PRIMARY KEY IDENTITY(1,1),
    fecha DATE NOT NULL,
    tabla_afectada VARCHAR(20) NOT NULL,
    columna_afectada VARCHAR(50) NOT NULL,
    usuario VARCHAR(20) NOT NULL DEFAULT(CURRENT_USER),
    tipo_modificacion VARCHAR(15) NOT NULL
);
GO
