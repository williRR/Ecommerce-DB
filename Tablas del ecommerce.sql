CREATE DATABASE ECOMMERCE ;
GO
USE ECOMMERCE;
GO 

-- TABLA EMPRESA	
CREATE TABLE empresa(
	nit VARCHAR(14) PRIMARY KEY ,
	nombre_comercial VARCHAR(50) not null,
	departamento VARCHAR(30) not null ,
	municipio VARCHAR(25) not null ,
	zona VARCHAR(25) null ,
	calle VARCHAR(25) null ,
	avenida VARCHAR(25) null ,
	telefono VARCHAR(10) not null ,
	correo_electronico VARCHAR(50) not null ,
	creacion DATETIME DEFAULT GETDATE() not null ,
	usuario VARCHAR(50) not null,
	fecha_modificacion DATETIME  not null,
	estado CHAR(1) CHECK(estado in( 'a' ,'n')) default 'a' -- ACTIVO O INACTIVO 

);
GO
-- TABLA DE CLIENTES
CREATE TABLE cliente (
	nit VARCHAR(14) PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL ,
	apellido VARCHAR(30) NOT NULL ,
	correo_electronico VARCHAR(50) NOT NULL,
	telefono VARCHAR(10) NOT NULL ,
	nacimiento DATE NOT NULL ,
	genero CHAR(1) Check(genero IN( 'm' ,'f')) NOT NULL,
	direccion VARCHAR(50),
	creacion DATETIME DEFAULT GETDATE() not null ,
	usuario VARCHAR(50) not null,
	fecha_modificacion DATETIME  not null,
	estado CHAR(1) CHECK(estado in('a','n')) default 'a' -- ACTIVO O INACTIVO 


);
GO

-- TABLA PARA EMPLEADOS
CREATE TABLE empleado (
    codigo_empleado VARCHAR(14) PRIMARY KEY,
    dni VARCHAR(16) NOT NULL ,
    primer_nombre VARCHAR(20) NOT NULL,
    segundo_nombre VARCHAR(20) NULL,
    tercer_nombre VARCHAR(20) NULL,
    primer_apellido VARCHAR(20) NOT NULL ,
    segundo_apellido VARCHAR(20)NOT NULL ,
    apellido_casada VARCHAR(20) NULL,
    direccion VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(50) NOT NULL,
    telefono VARCHAR(10)NOT NULL,
    fecha_alta DATE NOT NULL,
    fecha_baja DATE NULL ,
    genero CHAR(1) Check(genero IN( 'm' ,'f')) NOT NULL ,-- masculino y femenino
    nacimiento DATE NOT NULL ,
    creacion DATETIME DEFAULT GETDATE() NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    fecha_modificacion DATETIME NOT NULL,
    estado CHAR(1) CHECK(estado in('a','n')) default 'a' -- ACTIVO O INACTIVO 
);
GO
CREATE TABLE proveedor (
    codigo_proveedor VARCHAR(14) PRIMARY KEY,
    nombre_empresa VARCHAR(30) NOT NULL,
    primer_nombre VARCHAR(20) NOT NULL,
    segundo_nombre VARCHAR(20)NULL,
    primer_apellido VARCHAR(20) NOT NULL,
    segundo_apellido VARCHAR(20) NOT NULL ,
    fecha_comienzo_relacion DATE NULL,
    correo_electronico VARCHAR(50) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    telefono_fijo VARCHAR(10) NULL ,
    departamento VARCHAR(30) not null ,
	municipio VARCHAR(25) not null ,
	zona VARCHAR(25) null ,
	calle VARCHAR(25) null ,
	avenida VARCHAR(25) null ,
    creacion DATETIME DEFAULT GETDATE() NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    fecha_modificacion DATETIME NOT NULL,
    estado CHAR(1) CHECK(estado in('a','n')) default 'a' -- ACTIVO O INACTIVO 

	
);
GO
CREATE TABLE inventario (
    codigo_inventario VARCHAR(14) PRIMARY KEY,
	fk_proveedor VARCHAR(14),
    cantidad_disponible INT NOT NULL CHECK(cantidad_disponible >=1),
    precio_compra DECIMAL(10,2) NOT NULL CHECK(precio_compra >=1),
    fecha_abastecimiento DATE NOT NULL,
    ubicacion VARCHAR(20) NOT NULL,
    creacion DATETIME DEFAULT GETDATE() NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    fecha_modificacion DATETIME NOT NULL,
    estado CHAR(1) CHECK(estado in('a','n')) default 'a' -- ACTIVO O INACTIVO ,

	CONSTRAINT fk_proveedor FOREIGN KEY (fk_proveedor) REFERENCES proveedor(codigo_proveedor)
);
GO
-- tabla de presentacion de los productos
CREATE TABLE presentacion (
    correlativo INT PRIMARY KEY,
    capacidad VARCHAR(10) NOT NULL,
    unidad_envase VARCHAR(10)NOT NULL,
    descripcion VARCHAR(50) NOT NULL
);
GO
CREATE TABLE producto (
    codigo_producto VARCHAR(14) PRIMARY KEY,
    fk_inventario VARCHAR(14),
    fk_presentacion INT,
    precio_unitario DECIMAL(10,2) NOT NULL CHECK(precio_unitario>0),
    fecha_entrada DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    marca VARCHAR(20) NULL,
    creacion DATETIME DEFAULT GETDATE() NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    fecha_modificacion DATETIME NOT NULL,
    estado CHAR(1) CHECK(estado in('a','n')) default 'a' -- ACTIVO O INACTIVO ,
	
    CONSTRAINT fk_inventario FOREIGN KEY (fk_inventario) REFERENCES inventario(codigo_inventario),
    CONSTRAINT fk_presentacion FOREIGN KEY (fk_presentacion) REFERENCES presentacion(correlativo)

);
GO

CREATE TABLE venta (
    no_factura VARCHAR(50) PRIMARY KEY,
    fk_nit VARCHAR(14),
    fk_empresa VARCHAR(14),
    fk_empleado VARCHAR(14),
    fecha DATE NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL DEFAULT(0.01),

	CONSTRAINT fk_nit FOREIGN KEY (fk_nit) REFERENCES cliente(nit),
	CONSTRAINT fk_empresa FOREIGN KEY (fk_empresa) REFERENCES empresa(nit),
	CONSTRAINT fk_empleado FOREIGN KEY (fk_empleado) REFERENCES empleado(codigo_empleado)

);
GO
CREATE TABLE venta_detalle (
    codigo_detalle VARCHAR(50) PRIMARY KEY,
    fk_no_factura VARCHAR(50),
    fk_codigo_producto VARCHAR(14),
    nombre_producto VARCHAR(50) NOT NULL,
    cantidad INT CHECK(cantidad >=1) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL ,
    subtotal DECIMAL(10,2) NOT NULL ,

    CONSTRAINT fk_no_factura FOREIGN KEY (fk_no_factura) REFERENCES venta(no_factura),
    CONSTRAINT fk_codigo_producto FOREIGN KEY (fk_codigo_producto) REFERENCES producto(codigo_producto)
);
GO


CREATE TABLE compra (
    no_factura VARCHAR(50) PRIMARY KEY,
    fk_empresa VARCHAR(14),
    fk_proveedor VARCHAR(14),
    fecha DATE NOT NULL ,
    monto_total DECIMAL(10,2) NOT NULL DEFAULT(0.01),

	CONSTRAINT fk_proveedor FOREIGN KEY (fk_proveedor) REFERENCES proveedor(codigo_proveedor),
	CONSTRAINT fk_empresa FOREIGN KEY (fk_empresa) REFERENCES empresa(nit)
);
GO

CREATE TABLE compra_detalle (
    codigo_detalle VARCHAR(50) PRIMARY KEY,
    fk_no_factura VARCHAR(50),
    fk_codigo_producto VARCHAR(14),
    nombre_producto VARCHAR(50) NULL,
    cantidad INT CHECK(cantidad >=1) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL ,

    CONSTRAINT fk_no_factura FOREIGN KEY (fk_no_factura) REFERENCES compra(no_factura),
    CONSTRAINT fk_codigo_producto FOREIGN KEY (fk_codigo_producto) REFERENCES producto(codigo_producto)
);
GO


CREATE TABLE modificacion (
    correlativo VARCHAR(50) PRIMARY KEY,
    fecha DATE NOT NULL ,
    tabla_afectada VARCHAR(20) NOT NULL ,
    columna_afectada VARCHAR(50) NOT NULL ,
    usuario VARCHAR(20) NOT NULL DEFAULT(CURRENT_USER),
    tipo_modificacion VARCHAR(15) NOT NULL
);
GO
	


