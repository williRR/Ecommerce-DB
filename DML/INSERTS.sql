USE abarroteria

-- insertar datos en la tabla presentacion 
INSERT INTO presentacion (capacidad, unidad_envase, descripcion) VALUES
('500', 'botella', 'Botella de 500 mililitros'),
('1000', 'litro', 'Botella de 1 litro'),
('200', 'lata', 'Lata de 200 gramos'),
('1000', 'kilogramo', 'Bolsa de 1 kilogramo'),
('2000', 'litro', 'Botella de 2 litros'),
('100', 'gramo', 'Lata de 100 gramos'),
('50', 'mililitro', 'Botella de 50 mililitros'),
('5000', 'kilogramo', 'Bolsa de 5 kilogramos'),
('100', 'quintal', 'Bolsa de 1 quintal'),
('12', 'onza', 'Paquete de 12 onzas'),
('1', 'libra', 'Bolsa de 1 libra'),
('1', 'paquete', 'Paquete de productos variados'),
('24', 'caja', 'Caja de 24 unidades'),
('1', 'unidad', 'Producto individual'),
('12', 'docena', 'Docena de productos');

-- insertar datos en la tabla proveedor 
INSERT INTO proveedor (codigo_proveedor, nombre_empresa, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_comienzo_relacion, correo_electronico, telefono, telefono_fijo, departamento, municipio, zona, calle, avenida) VALUES
('PROV001', 'Proveedor A', 'Juan', 'Carlos', 'Pérez', 'Gómez', '2022-01-15', 'juan.perez@proveedora.com', '1234567890', '0987654321', 'Guatemala', 'Ciudad', 'Zona 10', 'Calle A', 'Avenida 5'),
('PROV002', 'Proveedor B', 'María', NULL, 'López', 'Hernández', '2023-05-20', 'maria.lopez@proveedorb.com', '1234567891', NULL, 'Escuintla', 'Escuintla', 'Zona 4', 'Calle B', NULL),
('PROV003', 'Proveedor C', 'Pedro', 'Luis', 'Martínez', 'Ortiz', '2023-09-01', 'pedro.martinez@proveedorc.com', '1234567892', '0987654322', 'Quetzaltenango', 'Quetzaltenango', 'Zona 3', 'Calle C', 'Avenida 6');


-- Insertar datos en la tabla inventario
INSERT INTO inventario (codigo_inventario, fk_proveedor, cantidad_disponible, precio_compra, fecha_abastecimiento, ubicacion) VALUES
('INV001', 'PROV001', 100, 5.00, '2024-01-01', 'Almacén 1'),
('INV002', 'PROV002', 150, 3.50, '2024-02-01', 'Almacén 2'),
('INV003', 'PROV003', 200, 4.00, '2024-03-01', 'Almacén 3'),
('INV004', 'PROV001', 300, 6.50, '2024-04-01', 'Almacén 1'),
('INV005', 'PROV002', 250, 7.25, '2024-05-01', 'Almacén 2'),
('INV006', 'PROV003', 100, 8.75, '2024-06-01', 'Almacén 3'),
('INV007', 'PROV001', 150, 9.00, '2024-07-01', 'Almacén 1'),
('INV008', 'PROV002', 200, 10.50, '2024-08-01', 'Almacén 2'),
('INV009', 'PROV003', 300, 12.00, '2024-09-01', 'Almacén 3'),
('INV010', 'PROV001', 400, 11.25, '2024-10-01', 'Almacén 1');

-- Insertar datos en la tabla producto
INSERT INTO producto (codigo_producto, nombre, fk_inventario, fk_presentacion, precio_unitario, fecha_entrada, fecha_vencimiento, marca) VALUES
('PROD001', 'Producto A', 'INV001', 1, 10.00, '2024-01-10', '2025-01-10', 'Marca A'),
('PROD002', 'Producto B', 'INV002', 2, 7.50, '2024-02-15', '2025-02-15', 'Marca B'),
('PROD003', 'Producto C', 'INV003', 3, 12.00, '2024-03-20', '2025-03-20', 'Marca C'),
('PROD004', 'Producto D', 'INV004', 4, 15.50, '2024-04-25', '2025-04-25', 'Marca D'),
('PROD005', 'Producto E', 'INV005', 5, 20.00, '2024-05-30', '2025-05-30', 'Marca E'),
('PROD006', 'Producto F', 'INV006', 6, 25.75, '2024-06-05', '2025-06-05', 'Marca F'),
('PROD007', 'Producto G', 'INV007', 7, 30.50, '2024-07-10', '2025-07-10', 'Marca G'),
('PROD008', 'Producto H', 'INV008', 8, 35.00, '2024-08-15', '2025-08-15', 'Marca H'),
('PROD009', 'Producto I', 'INV009', 9, 40.75, '2024-09-20', '2025-09-20', 'Marca I'),
('PROD010', 'Producto J', 'INV010', 10, 45.25, '2024-10-25', '2025-10-25', 'Marca J');

-- Insertar datos en la tabla empresa
INSERT INTO empresa (nit, nombre_comercial, departamento, municipio, zona, calle, avenida, telefono, correo_electronico) VALUES
('EMP001', 'Empresa XYZ', 'Guatemala', 'Ciudad', 'Zona 10', 'Calle C', 'Avenida 6', '1234567892', 'contacto@empresaXYZ.com');

-- Insertar datos en la tabla cliente
INSERT INTO cliente (nit, nombre, apellido, correo_electronico, telefono, nacimiento, genero, direccion) VALUES
('CLI001', 'Ana', 'Méndez', 'ana.mendez@cliente.com', '1234567893', '1990-05-15', 'f', 'Calle D 123'),
('CLI002', 'Luis', 'García', 'luis.garcia@cliente.com', '1234567894', '1985-12-25', 'm', 'Calle E 456'),
('CLI003', 'Carmen', 'López', 'carmen.lopez@cliente.com', '1234567895', '1992-03-18', 'f', 'Calle F 789'),
('CLI004', 'José', 'Pérez', 'jose.perez@cliente.com', '1234567896', '1988-07-11', 'm', 'Calle G 101'),
('CLI005', 'María', 'Ramírez', 'maria.ramirez@cliente.com', '1234567897', '1995-11-20', 'f', 'Calle H 202'),
('CLI006', 'Carlos', 'González', 'carlos.gonzalez@cliente.com', '1234567898', '1980-08-05', 'm', 'Calle I 303');

-- Insertar datos en la tabla empleado
INSERT INTO empleado (codigo_empleado, dni, primer_nombre, segundo_nombre, tercer_nombre, primer_apellido, segundo_apellido, apellido_casada, direccion, correo_electronico, telefono, fecha_alta, genero, nacimiento) VALUES 
('EMP001', '1234567890123456', 'Carlos', 'Eduardo', NULL, 'Martínez', 'Ramos', 'Sánchez', 'Calle F 789', 'carlos.martinez@empleado.com', '1234567895', '2023-06-01', 'm', '1980-11-30'),
('EMP002', '6543210987654321', 'Laura', NULL, 'Alejandra', 'Morales', 'Reyes', NULL, 'Calle G 101', 'laura.morales@empleado.com', '1234567896', '2023-07-01', 'f', '1992-08-22'),
('EMP003', '9876543210987654', 'Mario', 'Andrés', NULL, 'López', 'García', NULL, 'Calle H 202', 'mario.lopez@empleado.com', '1234567897', '2023-08-01', 'm', '1985-05-10'),
('EMP004', '4321098765432109', 'Sofía', 'Isabel', NULL, 'Pérez', 'Rodríguez', NULL, 'Calle I 303', 'sofia.perez@empleado.com', '1234567898', '2023-09-01', 'f', '1990-12-05'),
('EMP005', '3210987654321098', 'Diego', 'Fernando', NULL, 'Gómez', 'Hernández', NULL, 'Calle J 404', 'diego.gomez@empleado.com', '1234567899', '2023-10-01', 'm', '1983-01-15');


