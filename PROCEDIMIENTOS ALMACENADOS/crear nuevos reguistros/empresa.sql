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
    @correo_electronico VARCHAR(50)
AS
BEGIN

    BEGIN TRANSACTION;
	    SET NOCOUNT ON;

    BEGIN TRY
        -- DECLARAR VARIABLES DE MENSAJE Y C�DIGO
        DECLARE @codigo NVARCHAR(5) = '30001';
        DECLARE @mensaje NVARCHAR(250) = 'Error desconocido';



        -- VERIFICANDO LA LONGITUD DE LOS CAMPOS

        IF NOT (
            CASE WHEN len(@nit) >= LEN(@nit) THEN 1 ELSE 0 END = 1 AND
            CASE WHEN LEN(@nombre_comercial) <= 50 THEN 1 ELSE 0 END = 1 AND
            CASE WHEN LEN(@departamento) <= 30 THEN 1 ELSE 0 END = 1 AND
            CASE WHEN LEN(@municipio) <= 25 THEN 1 ELSE 0 END = 1 AND
            CASE WHEN LEN(@zona) <= 25 THEN 1 ELSE 0 END = 1 AND
            CASE WHEN LEN(@calle) <= 25 THEN 1 ELSE 0 END = 1 AND
            CASE WHEN LEN(@avenida) <= 25 THEN 1 ELSE 0 END = 1 AND
            CASE WHEN LEN(@telefono) <= 10 THEN 1 ELSE 0 END = 1 AND
            CASE WHEN LEN(@correo_electronico) <= 50 THEN 1 ELSE 0 END = 1
        )
        BEGIN
			
            SET @codigo = '10005'; -- C�digo de error por longitud incorrecta
            SET @mensaje = 'Error: Uno o m�s campos superan la longitud permitida.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- Lanza el error con el mensaje y c�digo
            RETURN;
        END;

        -- VERIFICANDO QUE EL TEL�FONO SEA NUM�RICO
        IF ISNUMERIC(@telefono) = 0
        BEGIN
            SET @codigo = '10002'; -- C�digo para tipo de dato no aceptado
            SET @mensaje = 'Error: La capacidad debe ser un valor num�rico.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- THROW con c�digo de error
            RETURN;
        END;
		-- VERIFICACI�N DE LA EXISTENCIA
        IF EXISTS (SELECT 1 FROM empresa WHERE nit = @nit)
        BEGIN
            SET @codigo = '10001';
            SET @mensaje = 'Error: El producto con este nombre ya existe.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- THROW con c�digo de error
            RETURN;
        END;
		ELSE 
		BEGIN 
        -- INSERCI�N DE DATOS EN LA TABLA EMPRESA
        INSERT INTO empresa (nit, nombre_comercial, departamento, municipio, zona, calle, avenida, telefono, correo_electronico)
        VALUES (@nit, @nombre_comercial, @departamento, @municipio, @zona, @calle, @avenida, @telefono, @correo_electronico);
		END 
        COMMIT TRANSACTION ; -- COMMIT de la transacci�n si todo es exitoso
		
        -- C�digo y mensaje de �xito
        SET @codigo = '00000';
        SET @mensaje = 'Insertado exitosamente';
        THROW 50000, @mensaje, 1;  -- THROW para mensaje de �xito

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
