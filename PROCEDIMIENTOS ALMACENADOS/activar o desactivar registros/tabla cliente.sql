CREATE OR ALTER PROCEDURE spEstadoCliente
    @nit VARCHAR(14)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON;
        BEGIN TRANSACTION;

        DECLARE @estado CHAR(1);

        -- Verificar existencia
        IF NOT EXISTS (SELECT 1 FROM cliente WHERE nit = @nit)
        BEGIN
            THROW 50000, 'No se encontró un cliente con ese NIT', 1;
        END;

        -- Obtener el estado actual
        SELECT @estado = estado FROM cliente WHERE nit = @nit;

        -- Alternar el estado
        SET @estado = CASE WHEN @estado = 'a' THEN 'n' ELSE 'a' END;

        -- Actualizar el estado
        UPDATE cliente
        SET estado = @estado
        WHERE nit = @nit;

        COMMIT TRANSACTION;
        PRINT 'Estado del cliente actualizado correctamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Manejo del error
        THROW;
    END CATCH;
END;
GO
