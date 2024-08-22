USE abarroteria
GO

CREATE OR ALTER PROCEDURE sp_insertarPresentacion
    @capacidad VARCHAR(10),
    @unidad_envase VARCHAR(10),
    @descripcion VARCHAR(50)
AS
BEGIN
    -- Inicia la transacción
    BEGIN TRANSACTION
    SET NOCOUNT ON

    BEGIN TRY
        DECLARE @codigo NVARCHAR(5) = '30001'; -- Valor predeterminado en caso de error no controlado
        DECLARE @mensaje NVARCHAR(250) = 'Error desconocido';

        -- Verificar que los datos sean los correctos
        IF ISNUMERIC(@capacidad) = 0
        BEGIN
            SET @codigo = '10002'; -- Código para tipo de dato no aceptado
            SET @mensaje = 'Error: La capacidad debe ser un valor numérico.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- THROW correcto con código de error
            RETURN;
        END
        
        IF LOWER(@unidad_envase) NOT IN 
        ('botella', 'lata', 'bolsa', 'litro', 'mililitro', 'gramo', 
         'kilogramo', 'quintal', 'onza', 'libra', 'paquete', 'caja', 'unidad', 'docena')
        BEGIN
            SET @codigo = '10002'; -- Código para tipo de dato no aceptado
            SET @mensaje = 'Error: la unidad del envase no es aceptada.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- THROW correcto con código de error
            RETURN;
        END

        -- Verificar si ya existe
        IF EXISTS (
            SELECT 1
            FROM presentacion
            WHERE capacidad = @capacidad AND unidad_envase = @unidad_envase
        )
        BEGIN
            SET @codigo = '10001';
            SET @mensaje = 'Error: El producto con este nombre ya existe.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- THROW correcto con código de error
            RETURN;
        END
        ELSE
        -- Si no existe, procedemos a ingresar los datos
        BEGIN
            INSERT INTO presentacion (capacidad, unidad_envase, descripcion)
            VALUES (@capacidad, @unidad_envase, @descripcion);
        END

        -- Confirmación del éxito de la transacción
        COMMIT TRANSACTION;

        -- Código y mensaje de éxito
        SET @codigo = '00000';
        SET @mensaje = 'Insertado exitosamente';
        THROW 50000, @mensaje, 1;  -- THROW para mensaje de éxito
    END TRY

    -- Manejo de errores
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION; -- Revertir en caso de error

        -- Mensaje de error detallado
        DECLARE @ErrorMsg NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorLine INT = ERROR_LINE();
        DECLARE @ErrorProcedure NVARCHAR(128) = ERROR_PROCEDURE();
        DECLARE @ErrorState INT = ERROR_STATE();
        DECLARE @ErrorXact INT = XACT_STATE();
        DECLARE @identitity_perdido NVARCHAR(40) = IDENT_CURRENT('presentacion'); 

        SELECT
            @codigo AS Codigo,
            @mensaje AS Mensaje,
            @ErrorProcedure AS ERROR_POCEDIMIENTO,
            @ErrorXact AS COMPROMETIDO_TRANSACCION,
            @identitity_perdido AS IDENITY_PERDIDO,
            @ErrorMsg AS MENSAJE_ERROR,
            @ErrorLine AS LINEA_ERROR,
            @ErrorSeverity AS ERROR_SEGURIDAD,
            @ErrorState AS ERROR_ESTADO,
            @ErrorNumber AS ERROR_NUMERO;
    END CATCH
END;
