CREATE OR ALTER PROCEDURE spEstadoEmpleado
    @codigo_empleado VARCHAR(14)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON;
        BEGIN TRANSACTION;

        DECLARE @estado CHAR(1);

        -- Verificar existencia
        IF NOT EXISTS (SELECT 1 FROM empleado WHERE codigo_empleado = @codigo_empleado)
        BEGIN
            THROW 50000, 'No se encontró un empleado con ese código', 1;
        END;

        -- Obtener el estado actual
        SELECT @estado = estado FROM empleado WHERE codigo_empleado = @codigo_empleado;

        -- Alternar el estado
        SET @estado = CASE WHEN @estado = 'a' THEN 'n' ELSE 'a' END;

        -- Actualizar el estado
        UPDATE empleado
        SET estado = @estado
        WHERE codigo_empleado = @codigo_empleado;

        COMMIT TRANSACTION;
        PRINT 'Estado del empleado actualizado correctamente.';
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Manejo del error
        THROW;
    END CATCH;
END;
GO


exec spEstadoEmpleado 'EMP001'


select* from empleado