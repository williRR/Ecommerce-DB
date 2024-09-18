CREATE OR ALTER PROCEDURE spEstadoInventario
    @codigo_inventario VARCHAR(14)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON;
        BEGIN TRANSACTION;

        DECLARE @estado CHAR(1);

        -- Verificar existencia
        IF NOT EXISTS (SELECT 1 FROM inventario WHERE codigo_inventario = @codigo_inventario)
        BEGIN
            THROW 50000, 'No se encontró un inventario con ese código', 1;
        END;

        -- Obtener el estado actual
        SELECT @estado = estado FROM inventario WHERE codigo_inventario = @codigo_inventario;

        -- Alternar el estado
        SET @estado = CASE WHEN @estado = 'a' THEN 'n' ELSE 'a' END;

        -- Actualizar el estado
        UPDATE inventario
        SET estado = @estado
        WHERE codigo_inventario = @codigo_inventario;

        COMMIT TRANSACTION;
        PRINT 'Estado del inventario actualizado correctamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Manejo del error
        THROW;
    END CATCH;
END;
GO
