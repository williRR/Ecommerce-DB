USE abarroteria;
GO

CREATE OR ALTER PROCEDURE InsertarDatosFacturaDesdeTemporal
AS
BEGIN
    BEGIN TRY
        -- Iniciar transacción
        BEGIN TRANSACTION;

        -- Insertar datos de la tabla ##temporal_factura a la tabla venta con monto_total inicial
        INSERT INTO venta (no_factura, fk_nit_cliente, fk_empresa, fk_empleado, fecha, monto_total)
        SELECT no_factura, fk_nit_cliente, fk_empresa, fk_empleado, fecha, 0.01
        FROM ##temporal_factura;

        -- Insertar datos de la tabla ##temporalDetalleFactura a la tabla venta_detalle
        INSERT INTO venta_detalle (codigo_detalle, fk_no_factura, fk_codigo_producto, nombre_producto, cantidad, precio_unitario, subtotal)
        SELECT NEWID(), fk_no_factura, fk_codigo_producto, nombre_producto, cantidad, precio_unitario, subtotal
        FROM ##temporalDetalleFactura;

        -- Actualizar monto_total en la tabla venta
        UPDATE v
        SET v.monto_total = t.total
        FROM venta v
        INNER JOIN (
            SELECT fk_no_factura, SUM(subtotal) AS total
            FROM ##temporalDetalleFactura
            GROUP BY fk_no_factura
        ) t ON v.no_factura = t.fk_no_factura;


        -- Actualizar la cantidad disponible en inventario
        UPDATE i
        SET cantidad_disponible = i.cantidad_disponible - t.cantidad
        FROM inventario i
        INNER JOIN (
            SELECT fk_codigo_producto, SUM(cantidad) AS cantidad
            FROM ##temporalDetalleFactura
            GROUP BY fk_codigo_producto
        ) t ON i.codigo_inventario = (
            SELECT fk_inventario
            FROM producto
            WHERE codigo_producto = t.fk_codigo_producto
        );

        -- Limpiar las tablas temporales si deseas eliminarlas después de la inserción
        DROP TABLE ##temporal_factura;
        DROP TABLE ##temporalDetalleFactura;

        -- Confirmar transacción
        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        -- Si ocurre un error, deshacer transacción
        ROLLBACK TRANSACTION;
        
        -- Opcional: Manejar el error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Lanzar error
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
