use abarroteria
go 

CREATE OR ALTER PROCEDURE sp_insertarProducto
    @codigo_producto VARCHAR(14),
    @fk_inventario VARCHAR(14),
    @fk_presentacion INT,
    @precio_unitario DECIMAL(10, 2),
    @fecha_entrada DATE,
    @fecha_vencimiento DATE,
    @marca VARCHAR(20)

AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Declarar código y mensaje para errores
        DECLARE @codigo NVARCHAR(5) = '30001';
        DECLARE @mensaje NVARCHAR(250) = 'Error desconocido';

        -- Validar que el precio unitario sea mayor que 0
        IF @precio_unitario <= 0
        BEGIN
            SET @codigo = '10004'; -- Código de error para precio no válido
            SET @mensaje = 'Error: El precio unitario debe ser mayor a 0.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;
            RETURN;
        END

        -- Validar que la fecha de vencimiento sea mayor que la fecha de entrada
        IF @fecha_vencimiento <= @fecha_entrada
        BEGIN
            SET @codigo = '10005'; -- Código de error para fecha no válida
            SET @mensaje = 'Error: La fecha de vencimiento debe ser mayor que la fecha de entrada.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;
            RETURN;
        END

        -- Validar que el producto no exista ya en la base de datos
        IF EXISTS (SELECT 1 FROM producto WHERE codigo_producto = @codigo_producto)
        BEGIN
            SET @codigo = '10001';
            SET @mensaje = 'Error: El código de producto ya existe.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;
            RETURN;
        END

        -- Insertar el nuevo producto
        INSERT INTO producto (
            codigo_producto, fk_inventario, fk_presentacion, 
            precio_unitario, fecha_entrada, fecha_vencimiento, 
            marca
        )
        VALUES (
            @codigo_producto, @fk_inventario, @fk_presentacion, 
            @precio_unitario, @fecha_entrada, @fecha_vencimiento, 
            @marca
        );

        COMMIT TRANSACTION;

        -- Mensaje de éxito
        SET @codigo = '00000';
        SET @mensaje = 'Producto insertado exitosamente';
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
