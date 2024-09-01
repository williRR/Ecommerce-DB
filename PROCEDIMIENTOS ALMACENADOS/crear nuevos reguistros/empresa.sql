USE abarroteria;
GO

-- PROCEDIMIENTO ALMACENADO PARA INGRESAR DATOS EMPRESA
CREATE OR ALTER PROCEDURE sp_insertarEmpresa
    @nit VARCHAR(14),
    @nombre_comercial VARCHAR(50),
    @departamento VARCHAR(30),
    @municipio VARCHAR(25),
    @zona VARCHAR(25),
    @calle VARCHAR(25),
    @avenida VARCHAR(25),
    @telefono VARCHAR(10),
    @correo VARCHAR(50)
AS
BEGIN

    BEGIN TRANSACTION;
    SET NOCOUNT ON;

    BEGIN TRY
        -- DECLARAR VARIABLES DE MENSAJE Y CÓDIGO
        DECLARE @codigo NVARCHAR(5) = '30001';
        DECLARE @mensaje NVARCHAR(250) = 'Error desconocido';



        -- VERIFICANDO QUE EL TELÉFONO SEA NUMÉRICO
        IF ISNUMERIC(@telefono) = 0
        BEGIN
            SET @codigo = '10002'; -- Código para tipo de dato no aceptado
            SET @mensaje = 'Error: El teléfono debe ser un valor numérico.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- THROW con código de error
            RETURN;
        END;

        -- VERIFICACIÓN DE LA EXISTENCIA
        IF EXISTS (SELECT 1 FROM empresa WHERE nit = @nit)
        BEGIN
            SET @codigo = '10001';
            SET @mensaje = 'Error: El NIT de la empresa ya existe.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- THROW con código de error
            RETURN;
        END;
        ELSE 
        BEGIN 
            -- INSERCIÓN DE DATOS EN LA TABLA EMPRESA
            INSERT INTO empresa (nit, nombre_comercial, departamento, municipio, zona, calle, avenida, telefono, correo_electronico)
            VALUES (@nit, @nombre_comercial, @departamento, @municipio, @zona, @calle, @avenida, @telefono, @correo);
        END 

        COMMIT TRANSACTION ; -- COMMIT de la transacción si todo es exitoso

        -- Código y mensaje de éxito
        SET @codigo = '00000';
        SET @mensaje = 'Insertado exitosamente';
        THROW 50000, @mensaje, 1;  -- THROW para mensaje de éxito

    END TRY

    BEGIN CATCH

        -- Mensaje de error detallado
        DECLARE @ErrorMsg NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorLine INT = ERROR_LINE();
        DECLARE @ErrorProcedure NVARCHAR(128) = ERROR_PROCEDURE();
        DECLARE @ErrorState INT = ERROR_STATE();
        DECLARE @ErrorXact INT = XACT_STATE();
        DECLARE @identitity_perdido NVARCHAR(40) = IDENT_CURRENT('empresa'); 

        SELECT
            @codigo AS Codigo,
            @mensaje AS Mensaje,
            @ErrorProcedure AS ERROR_PROCEDIMIENTO,
            @ErrorXact AS COMPROMETIDO_TRANSACCION,
            @identitity_perdido AS IDENTITY_PERDIDO,
            @ErrorMsg AS MENSAJE_ERROR,
            @ErrorLine AS LINEA_ERROR,
            @ErrorSeverity AS ERROR_SEGURIDAD,
            @ErrorState AS ERROR_ESTADO,
            @ErrorNumber AS ERROR_NUMERO;
			
    END CATCH
	
END;
