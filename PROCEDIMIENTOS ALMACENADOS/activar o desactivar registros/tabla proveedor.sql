USE abarroteria
GO

-- PROCEDIMIENTO ALMACENADO PARA ACTUALIZAR EL ESTADO DE UN PROVEEDOR (ACTIVO/INACTIVO)
CREATE OR ALTER PROCEDURE spEstadoProveedor
    @llave_primaria VARCHAR(14)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON;

        -- Declaración de variables para manejo de mensajes y código
        DECLARE @codigo NVARCHAR(5) = '30001';
        DECLARE @mensaje NVARCHAR(250) = 'Error desconocido';
        DECLARE @estado CHAR(1);  -- Variable para el estado

        -- Iniciar transacción
        BEGIN TRANSACTION;

        -- Verificar si el proveedor existe
        IF NOT EXISTS (SELECT 1 FROM proveedor WHERE codigo_proveedor = @llave_primaria)
        BEGIN
            SET @codigo = '10001';
            SET @mensaje = 'Ningún dato coincide, inténtelo de nuevo';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- Lanzar excepción con código de error
            RETURN;
        END;

        -- Verificar el estado actual del proveedor
        SELECT @estado = estado FROM proveedor WHERE codigo_proveedor = @llave_primaria;

        -- Alternar el estado (si es 'a', cambiar a 'n', si es 'n', cambiar a 'a')
        SET @estado = CASE 
		WHEN @estado = 'a' THEN 'n'
		ELSE 'a' END;

        -- Actualizar el estado del proveedor
        UPDATE proveedor
        SET estado = @estado
        WHERE codigo_proveedor = @llave_primaria;

        -- Confirmar la transacción
        COMMIT TRANSACTION;

        -- Mensaje de éxito (opcional)
        PRINT 'Estado del proveedor actualizado correctamente.';

    END TRY

    BEGIN CATCH
        -- En caso de error, revertir la transacción
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Obtener detalles del error
        DECLARE @ErrorMsg NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorLine INT = ERROR_LINE();
        DECLARE @ErrorProcedure NVARCHAR(128) = ERROR_PROCEDURE();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Seleccionar el mensaje de error detallado
        SELECT
            @codigo AS Codigo,
            @mensaje AS Mensaje,
            @ErrorProcedure AS ERROR_PROCEDIMIENTO,
            @ErrorMsg AS MENSAJE_ERROR,
            @ErrorLine AS LINEA_ERROR,
            @ErrorSeverity AS ERROR_GRAVEDAD,
            @ErrorState AS ERROR_ESTADO,
            @ErrorNumber AS ERROR_NUMERO;

        -- Lanza el error al finalizar
        THROW;
    END CATCH;
END;
GO

