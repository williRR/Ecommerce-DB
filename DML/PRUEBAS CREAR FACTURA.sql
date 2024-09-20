use abarroteria
go 
-- Insertar datos en la tabla presentacion
exec crearFacturaVenta '12' ,'CLI002','EMP001','EMP002'

-- Ejecutar el procedimiento almacenado para insertar un producto en una factura
EXEC InsertarProductosFactura 
    @no_factura = '12', 
    @codigo_producto = 'PROD003', 
    @cantidad = 2;

-- Ejecutar el procedimiento almacenado para insertar otro producto en la misma factura
EXEC InsertarProductosFactura 
    @no_factura = '12', 
    @codigo_producto = 'PROD004', 
    @cantidad = 10;

EXEC InsertarProductosFactura 
    @no_factura = '12', 
    @codigo_producto = 'PROD005', 
    @cantidad = 10;


	select * from inventario







exec InsertarDatosFacturaDesdeTemporal

	select * from venta
	select * from venta_detalle

	select * from inventario

	select * from modificacion