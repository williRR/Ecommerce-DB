CREATE OR ALTER PROCEDURE spEstadoPresentacion
    @correlativo INT
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON;
        BEGIN TRANSACTION;

        DECLARE @estado CHAR(1);

        -- Verificar existencia
        IF NOT EXISTS (SELECT 1 FROM presentacion WHERE correlativo = @correlativo)
        BEGIN
            THROW 50000, 'No se encontró una presentación con ese correlativo', 1;
        END;

        -- Obtener el estado actual
        SELECT @estado = estado FROM presentacion WHERE correlativo = @correlativo;

        -- Alternar el estado
        SET @estado = CASE WHEN @estado = 'a' THEN 'n' ELSE 'a' END;

        -- Actualizar el estado
        UPDATE presentacion
        SET estado = @estado
        WHERE correlativo = @correlativo;

        COMMIT TRANSACTION;
        PRINT 'Estado de la presentación actualizado correctamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Manejo del error
        THROW;
    END CATCH;
END;
GO
