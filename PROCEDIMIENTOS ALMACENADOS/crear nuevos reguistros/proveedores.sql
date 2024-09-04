USE abarroteria
GO 

CREATE OR ALTER PROCEDURE sp_insertarProveedor
-- campos requeridos para la informacion de los proveedores 
	@codigo_proveedor	VARCHAR(14) ,
	@nombre_empresa VARCHAR(20),
	@primer_nombre	VARCHAR(20),
	@segundo_nombre	VARCHAR(20),
	@primer_apellido	VARCHAR(20),
	@segundo_apellido VARCHAR(20),
	@fecha_relacion	DATE ,
	@correo VARCHAR(50),
	@telefono VARCHAR(10),
	@telefono_fijo VARCHAR(10),
	@departamento	VARCHAR(30),
	@municipio VARCHAR(25),
	@zona	VARCHAR(25),
	@calle	VARCHAR(25),
	@avenida VARCHAR(25)

	AS

	BEGIN

	

		BEGIN TRANSACTION
		BEGIN TRY
		SET NOCOUNT ON 

			-- DECLARAR VARIABLES DE MENSAJE Y CÓDIGO
        DECLARE @codigo NVARCHAR(5) = '30001';
        DECLARE @mensaje NVARCHAR(250) = 'Error desconocido';
		
		-- validacion campo fecha relacion no sea mayor a la fecha actual 
			IF @fecha_relacion > GETDATE()
				BEGIN
				SET @codigo = '10003'; -- Código para tipo de dato no aceptado
				SET @mensaje = 'Error: La fecha no puede ser futura.';
				ROLLBACK TRANSACTION;
				THROW 50000, @mensaje, 1;  -- THROW con código de error
				END 
		-- validacion campo numeros de telefono 
			IF ISNUMERIC(@telefono)= 0 
				BEGIN
				SET @codigo = '10002'; -- Código para tipo de dato no aceptado
				SET @mensaje = 'Error: El teléfono debe ser un valor numérico.';
				ROLLBACK TRANSACTION;
				THROW 50000, @mensaje, 1;  -- THROW con código de error				
				END 
		-- validacion campo numeros de telefono FIJO 
			IF ISNUMERIC(@telefono_fijo)= 0 
				BEGIN
				SET @codigo = '10002'; -- Código para tipo de dato no aceptado
				SET @mensaje = 'Error: El teléfono debe ser un valor numérico.';
				ROLLBACK TRANSACTION;
				THROW 50000, @mensaje, 1;  -- THROW con código de error				
				END

			-- validando la existencia 
			IF EXISTS (SELECT 1 FROM proveedor WHERE codigo_proveedor = @codigo)
				BEGIN 
				SET @codigo = '10001';
				SET @mensaje = 'Error: El CODIGO del proveedor  ya existe.';
				ROLLBACK TRANSACTION;
				THROW 50000, @mensaje, 1;  -- THROW con código de error
				RETURN;
				END
		    ELSE 
				BEGIN 
					INSERT INTO proveedor(codigo_proveedor,nombre_empresa,primer_nombre ,segundo_nombre,primer_apellido,segundo_apellido,
					fecha_comienzo_relacion ,correo_electronico,telefono,telefono_fijo,departamento,municipio,zona,calle,avenida)

					VALUES (@codigo_proveedor,@nombre_empresa,@primer_nombre,@segundo_nombre,@primer_apellido ,@segundo_apellido,@fecha_relacion,
					@correo,@telefono,@telefono_fijo,@departamento,@municipio,@zona,@calle,@avenida);
				END 


		COMMIT TRANSACTION 

	 -- Código y mensaje de éxito que se muestra en pantalla 
        SET @codigo = '00000';
        SET @mensaje = 'Insertado exitosamente';
        print @mensaje;  

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
	END 
	

