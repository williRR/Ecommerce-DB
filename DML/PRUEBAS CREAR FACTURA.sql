use abarroteria

-- Insertar datos en la tabla presentacion
exec crearFacturaVenta '10' ,'CLI002','EMP001','EMP002'

-- Ejecutar el procedimiento almacenado para insertar un producto en una factura
EXEC InsertarProductosFactura 
    @no_factura = '10', 
    @codigo_producto = 'PROD001', 
    @cantidad = 2;

-- Ejecutar el procedimiento almacenado para insertar otro producto en la misma factura
EXEC InsertarProductosFactura 
    @no_factura = '10', 
    @codigo_producto = 'PROD002', 
    @cantidad = 10;


	select * from inventario







exec InsertarDatosFacturaDesdeTemporal


	select * from venta_detalle

	select * from inventario

	select * from modificacion