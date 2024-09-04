USE  abarroteria ;
go 

CREATE OR ALTER PROCEDURE sp_insertarCliente
	@nit VARCHAR(14),
	@nombre VARCHAR(30),
	@apellido VARCHAR(30),
	@correo	VARCHAR(50),
	@telefono VARCHAR(10),
	@nacimiento DATE,
	@genero CHAR(1),
	@direccion VARCHAR(50)

	AS

	BEGIN 
		BEGIN TRANSACTION 
			
		BEGIN TRY
		SET NOCOUNT ON
		-- DECLARAR VARIABLES DE MENSAJE Y CÓDIGO
        DECLARE @codigo NVARCHAR(5) = '30001';
        DECLARE @mensaje NVARCHAR(250) = 'Error desconocido';



		
		-- validamos que el valor que insertemos en numero de telefono sean solo numeros 
		-- usamos la funcion isnumeric que nos devuelve cero si algun valor no es numerico
		IF ISNUMERIC(@telefono) = 0 
			BEGIN 
			SET @codigo = '10002'; -- Código para tipo de dato no aceptado
            SET @mensaje = 'Error: El teléfono debe ser un valor numérico.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- THROW con código de error
            RETURN ;
			END 
			-- validando que la fecha ingresada no sea futura a la fecha actual 
		IF @nacimiento > GETDATE()
			BEGIN 
			SET @codigo = '10003'; -- Código para tipo de dato no aceptado
            SET @mensaje = 'Error: La fecha no puede ser futura.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- THROW con código de error
            RETURN ;

			END 

		-- validamos que el cliente no exista mediante el nit
		 IF EXISTS (SELECT 1 FROM cliente WHERE nit = @nit )
			BEGIN
			SET @codigo = '10001';
            SET @mensaje = 'Error: El NIT de la empresa ya existe.';
            ROLLBACK TRANSACTION;
            THROW 50000, @mensaje, 1;  -- THROW con código de error
            RETURN;
			END 

			-- si no se producen estos errores procedemos a insertar los demas registros 
		ELSE 
			BEGIN
				INSERT INTO cliente (nit,nombre,apellido,correo_electronico,telefono,nacimiento,genero,direccion)
				VALUES (@nit,@nombre,@apellido,@correo,@telefono,@nacimiento,@genero,@direccion)
			END 


		COMMIT TRANSACTION 

	 -- Código y mensaje de éxito
        SET @codigo = '00000';
        SET @mensaje = 'Insertado exitosamente';
        print @mensaje;  -- THROW para mensaje de éxito

		END TRY 


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
        DECLARE @identitity_perdido NVARCHAR(40) = IDENT_CURRENT('Cliente'); 

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
	END ;