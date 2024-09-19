use abarroteria

-- Insertar datos en la tabla presentacion
exec crearFacturaVenta '1' ,'CLI002','EMP001','EMP002'

-- Ejecutar el procedimiento almacenado para insertar un producto en una factura
EXEC InsertarProductosFactura 
    @no_factura = '1', 
    @codigo_producto = 'PROD001', 
    @cantidad = 10;

-- Ejecutar el procedimiento almacenado para insertar otro producto en la misma factura
EXEC InsertarProductosFactura 
    @no_factura = '1', 
    @codigo_producto = 'PROD002', 
    @cantidad = 10;

-- Ejecutar el procedimiento almacenado para insertar un producto en una factura diferente
EXEC InsertarProductosFactura 
    @no_factura = '1', 
    @codigo_producto = 'PROD001', 
    @cantidad = 10;


	exec InsertarDatosFacturaDesdeTemporal


	select * from venta_detalle

	select * from inventario

	select * from modificacion