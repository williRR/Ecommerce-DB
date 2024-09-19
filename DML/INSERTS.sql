

INSERT INTO presentacion (capacidad, unidad_envase, descripcion) VALUES 
('500ml', 'botella', 'Botella de 500 mililitros'),
('1L', 'botella', 'Botella de 1 litro'),
('200g', 'lata', 'Lata de 200 gramos');

-- Insertar datos en la tabla proveedor
INSERT INTO proveedor (codigo_proveedor, nombre_empresa, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_comienzo_relacion, correo_electronico, telefono, telefono_fijo, departamento, municipio, zona, calle, avenida) VALUES 
('PROV001', 'Proveedor A', 'Juan', 'Carlos', 'Pérez', 'Gómez', '2022-01-15', 'juan.perez@proveedora.com', '1234567890', '0987654321', 'Guatemala', 'Ciudad', 'Zona 10', 'Calle A', 'Avenida 5'),
('PROV002', 'Proveedor B', 'María', NULL, 'López', 'Hernández', '2023-05-20', 'maria.lopez@proveedorb.com', '1234567891', NULL, 'Escuintla', 'Escuintla', 'Zona 4', 'Calle B', NULL);

-- Insertar datos en la tabla inventario
INSERT INTO inventario (codigo_inventario, fk_proveedor, cantidad_disponible, precio_compra, fecha_abastecimiento, ubicacion) VALUES 
('INV001', 'PROV001', 100, 5.00, '2024-01-01', 'Almacén 1'),
('INV002', 'PROV002', 150, 3.50, '2024-02-01', 'Almacén 2');

-- Insertar datos en la tabla producto
INSERT INTO producto (codigo_producto, nombre, fk_inventario, fk_presentacion, precio_unitario, fecha_entrada, fecha_vencimiento, marca) VALUES 
('PROD001', 'Producto A', 'INV001', 1, 10.00, '2024-01-10', '2025-01-10', 'Marca A'),
('PROD002', 'Producto B', 'INV002', 2, 7.50, '2024-02-15', '2025-02-15', 'Marca B');

-- Insertar datos en la tabla empresa
INSERT INTO empresa (nit, nombre_comercial, departamento, municipio, zona, calle, avenida, telefono, correo_electronico) VALUES 
('EMP001', 'Empresa XYZ', 'Guatemala', 'Ciudad', 'Zona 10', 'Calle C', 'Avenida 6', '1234567892', 'contacto@empresaXYZ.com');

-- Insertar datos en la tabla cliente
INSERT INTO cliente (nit, nombre, apellido, correo_electronico, telefono, nacimiento, genero, direccion) VALUES 
('CLI001', 'Ana', 'Méndez', 'ana.mendez@cliente.com', '1234567893', '1990-05-15', 'f', 'Calle D 123'),
('CLI002', 'Luis', 'García', 'luis.garcia@cliente.com', '1234567894', '1985-12-25', 'm', 'Calle E 456');

-- Insertar datos en la tabla empleado
INSERT INTO empleado (codigo_empleado, dni, primer_nombre, segundo_nombre, tercer_nombre, primer_apellido, segundo_apellido, apellido_casada, direccion, correo_electronico, telefono, fecha_alta, genero, nacimiento) VALUES 
('EMP001', '1234567890123456', 'Carlos', 'Eduardo', NULL, 'Martínez', 'Ramos', 'Sánchez', 'Calle F 789', 'carlos.martinez@empleado.com', '1234567895', '2023-06-01', 'm', '1980-11-30'),
('EMP002', '6543210987654321', 'Laura', NULL, 'Alejandra', 'Morales', 'Reyes', NULL, 'Calle G 101', 'laura.morales@empleado.com', '1234567896', '2023-07-01', 'f', '1992-08-22');


