use abarroteria
go 



CREATE OR ALTER PROCEDURE sp_insertarInventario
    @codigo_inventario VARCHAR(14),
    @fk_proveedor VARCHAR(14),
    @cantidad_disponible INT,
    @precio_compra DECIMAL(10, 2),
    @fecha_abastecimiento DATE,
    @ubicacion VARCHAR(20)

AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Declarar código y mensaje para errores
        DECLARE @codigo NVARCHAR(5) = '30001';
        DECLARE @mensaje NVARCHAR(250) = 'Error desconocido';

        -- Validar que la cantidad disponible sea mayor o igual a 1
        IF @cantidad_disponible < 1
        BEGIN
            SET @codigo = '10004'; -- Código de error para cantidad no válida
            SET @mensaje = 'Error: La cantidad disponible debe ser mayor o igual a 1.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;
            RETURN;
        END

        -- Validar que el precio de compra sea mayor o igual a 1
        IF @precio_compra < 1
        BEGIN
            SET @codigo = '10005'; -- Código de error para precio no válido
            SET @mensaje = 'Error: El precio de compra debe ser mayor o igual a 1.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;
            RETURN;
        END

        -- Validar que la fecha de abastecimiento no sea futura
        IF @fecha_abastecimiento > GETDATE()
        BEGIN
            SET @codigo = '10006'; -- Código de error para fecha no válida
            SET @mensaje = 'Error: La fecha de abastecimiento no puede ser futura.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;
            RETURN;
        END

        -- Validar que el inventario no exista ya en la base de datos
        IF EXISTS (SELECT 1 FROM inventario WHERE codigo_inventario = @codigo_inventario)
        BEGIN
            SET @codigo = '10001';
            SET @mensaje = 'Error: El código de inventario ya existe.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;
            RETURN;
        END

        -- Insertar el nuevo inventario
        INSERT INTO inventario (
            codigo_inventario, fk_proveedor, cantidad_disponible, 
            precio_compra, fecha_abastecimiento, ubicacion 
            
        )
        VALUES (
            @codigo_inventario, @fk_proveedor, @cantidad_disponible, 
            @precio_compra, @fecha_abastecimiento, @ubicacion
        );

        COMMIT TRANSACTION;

        -- Mensaje de éxito
        SET @codigo = '00000';
        SET @mensaje = 'Insertado exitosamente';
        PRINT @mensaje;

    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION; -- Revertir en caso de error

        -- Capturar y mostrar detalles del error
        DECLARE @ErrorMsg NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorLine INT = ERROR_LINE();
        DECLARE @ErrorProcedure NVARCHAR(128) = ERROR_PROCEDURE();
        DECLARE @ErrorState INT = ERROR_STATE();
        DECLARE @ErrorXact INT = XACT_STATE();

        SELECT
            @codigo AS Codigo,
            @mensaje AS Mensaje,
            @ErrorProcedure AS ERROR_PROCEDIMIENTO,
            @ErrorXact AS COMPROMETIDO_TRANSACCION,
            @ErrorMsg AS MENSAJE_ERROR,
            @ErrorLine AS LINEA_ERROR,
            @ErrorSeverity AS ERROR_SEGURIDAD,
            @ErrorState AS ERROR_ESTADO,
            @ErrorNumber AS ERROR_NUMERO;
    END CATCH
END;
