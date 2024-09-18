CREATE OR ALTER PROCEDURE spEstadoProducto
    @codigo_producto VARCHAR(14)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON;
        BEGIN TRANSACTION;

        DECLARE @estado CHAR(1);

        -- Verificar existencia
        IF NOT EXISTS (SELECT 1 FROM producto WHERE codigo_producto = @codigo_producto)
        BEGIN
            THROW 50000, 'No se encontró un producto con ese código', 1;
        END;

        -- Obtener el estado actual
        SELECT @estado = estado FROM producto WHERE codigo_producto = @codigo_producto;

        -- Alternar el estado
        SET @estado = CASE WHEN @estado = 'a' THEN 'n' ELSE 'a' END;

        -- Actualizar el estado
        UPDATE producto
        SET estado = @estado
        WHERE codigo_producto = @codigo_producto;

        COMMIT TRANSACTION;
        PRINT 'Estado del producto actualizado correctamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Manejo del error
        THROW;
    END CATCH;
END;
GO
