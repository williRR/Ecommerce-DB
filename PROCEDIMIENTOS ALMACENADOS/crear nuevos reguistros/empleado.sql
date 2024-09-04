USE abarroteria;
GO

CREATE OR ALTER PROCEDURE sp_insertarEmpleado
    @codigo_empleado VARCHAR(14),
    @dni VARCHAR(16),
    @primer_nombre VARCHAR(20),
    @segundo_nombre VARCHAR(20) = NULL,
    @tercer_nombre VARCHAR(20) = NULL,
    @primer_apellido VARCHAR(20),
    @segundo_apellido VARCHAR(20),
    @apellido_casada VARCHAR(20) = NULL,
    @direccion VARCHAR(50),
    @correo_electronico VARCHAR(50),
    @telefono VARCHAR(10),
    @fecha_alta DATE,
    @fecha_baja DATE = NULL,
    @genero CHAR(1),
    @nacimiento DATE

AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        SET NOCOUNT ON;

        -- DECLARAR VARIABLES DE MENSAJE Y CÓDIGO
        DECLARE @codigo NVARCHAR(5) = '30001';
        DECLARE @mensaje NVARCHAR(250) = 'Error desconocido';

        -- Validar que el teléfono sea numérico
        IF ISNUMERIC(@telefono) = 0
        BEGIN
            SET @codigo = '10002'; -- Código para tipo de dato no aceptado
            SET @mensaje = 'Error: El teléfono debe ser un valor numérico.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;
            RETURN;
        END

        -- Validar que la fecha de nacimiento no sea futura
        IF @nacimiento > GETDATE()
        BEGIN
            SET @codigo = '10003'; -- Código para tipo de dato no aceptado
            SET @mensaje = 'Error: La fecha de nacimiento no puede ser futura.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;
            RETURN;
        END

        -- Validar que el empleado no exista (por código o DNI)
        IF EXISTS (SELECT 1 FROM empleado WHERE codigo_empleado = @codigo_empleado OR dni = @dni)
        BEGIN
            SET @codigo = '10001'; -- Código para registro duplicado
            SET @mensaje = 'Error: El código de empleado o el DNI ya existe.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;
            RETURN;
        END

        -- Insertar los datos si no hay errores
        INSERT INTO empleado (codigo_empleado, dni, primer_nombre, segundo_nombre, tercer_nombre, 
                              primer_apellido, segundo_apellido, apellido_casada, direccion, 
                              correo_electronico, telefono, fecha_alta, fecha_baja, genero, 
                              nacimiento)
        VALUES (@codigo_empleado, @dni, @primer_nombre, @segundo_nombre, @tercer_nombre, 
                @primer_apellido, @segundo_apellido, @apellido_casada, @direccion, 
                @correo_electronico, @telefono, @fecha_alta, @fecha_baja, @genero, 
                @nacimiento);

        COMMIT TRANSACTION;

        -- Mensaje de éxito
        SET @codigo = '00000';
        SET @mensaje = 'Empleado insertado exitosamente';
        PRINT @mensaje;

    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION; -- Revertir en caso de error

        -- Obtener detalles del error
        DECLARE @ErrorMsg NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorLine INT = ERROR_LINE();
        DECLARE @ErrorProcedure NVARCHAR(128) = ERROR_PROCEDURE();
        DECLARE @ErrorState INT = ERROR_STATE();
        DECLARE @ErrorXact INT = XACT_STATE();

        -- Mostrar el error
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
