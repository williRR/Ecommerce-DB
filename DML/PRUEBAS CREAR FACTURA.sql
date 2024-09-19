use abarroteria

-- Insertar datos en la tabla presentacion
exec crearFacturaVenta '4' ,'CLI002','EMP001','EMP002'

-- Ejecutar el procedimiento almacenado para insertar un producto en una factura
EXEC InsertarProductosFactura 
    @no_factura = '4', 
    @codigo_producto = 'PROD001', 
    @cantidad = 80;

-- Ejecutar el procedimiento almacenado para insertar otro producto en la misma factura
EXEC InsertarProductosFactura 
    @no_factura = '4', 
    @codigo_producto = 'PROD002', 
    @cantidad = 100;

-- Ejecutar el procedimiento almacenado para insertar un producto en una factura diferente
EXEC InsertarProductosFactura 
    @no_factura = '2', 
    @codigo_producto = 'PROD001', 
    @cantidad = 10;


	exec InsertarDatosFacturaDesdeTemporal


