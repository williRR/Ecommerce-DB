use abarroteria
GO 
select * from presentacion

exec sp_insertarPresentacion '01','litros','agregando nuevas presentacionses'

CREATE OR ALTER PROCEDURE sp_insertarPresentacion
	@capacidad VARCHAR(10) ,
	@unidad_envase VARCHAR(10),
	@descripcion VARCHAR(50)

AS
BEGIN 

	
	--inicia la transaccion
	BEGIN TRANSACTION 

	BEGIN TRY 

	DECLARE @codigo NVARCHAR(5) = '30001'; -- Valor predeterminado en caso de error no controlado
	DECLARE @Mensaje NVARCHAR(250)  =  'Error desconocido';


	-- verificar que los datos sean los correctos 

	IF ISNUMERIC(@capacidad) = 0
		BEGIN 
			SET @codigo = '10002'; -- Código para tipo de dato no aceptado
            SET @mensaje = 'Error: La capacidad debe ser un valor numérico.';
			ROLLBACK TRANSACTION;
			RETURN;
		END 
	IF LOWER(@unidad_envase) NOT IN ('botella', 'lata', 'bolsa', 'litro', 'mililitro', 'gramo', 'kilogramo', 'quintal', 'onza', 'libra', 'paquete', 'caja', 'unidad', 'docena')
	BEGIN
			SET @codigo = '10002'; -- Código para tipo de dato no aceptado
            SET @mensaje = 'Error: la unidad del envase no es aceptada.';
			ROLLBACK TRANSACTION;
			RETURN;
	END 

		-- verificar si ya existe 
	 IF EXISTS (
				SELECT 1
				FROM presentacion
				WHERE capacidad  = @capacidad AND unidad_envase= @unidad_envase
			
				)
		-- en dado caso esto mostrara un mensaje 
		BEGIN 
            SET @codigo = '10001';
            SET @mensaje = 'Error: El producto con este nombre ya existe.';
			ROLLBACK TRANSACTION ;
			RETURN; -- para salir de procedimiento 
		END;

	 ELSE 
	 -- si no existe,procedemos a  ingresar los datos 
		BEGIN
			INSERT INTO presentacion (capacidad , unidad_envase, descripcion)
			VALUES (@capacidad, @unidad_envase,@descripcion);
		END ;
		-- Confirmación del éxito de la transacción
		COMMIT TRANSACTION ;
		-- codigo y mensaje de exito 
			SET @codigo = '00000';
            SET @mensaje = 'Insertado exitosamente';-- confirmar si todo a salido bien 
	END TRY 


	-- manejo de errores 
	BEGIN CATCH
	-- Manejo de errores durante la inserción
        SET @codigo = '20001';
        SET @mensaje = 'Error al insertar el producto: ' + ERROR_MESSAGE();


		IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION ;-- revertir en caso de error 

	-- Mensaje de error detallado
        DECLARE @ErrorMsg NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorState INT = ERROR_STATE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorLine INT = ERROR_LINE();
        DECLARE @ErrorProcedure NVARCHAR(128) = ERROR_PROCEDURE();

		PRINT  'Error en el procedimiento ' + @ErrorProcedure + ' ,Mensaje  ' + @ErrorMsg +
		      ' , Línea: ' + CAST(@ErrorLine AS NVARCHAR(10)) + 
		      ', Severidad: ' + CAST(@ErrorSeverity AS NVARCHAR(10)) + 
		      ', Estado: ' + CAST(@ErrorState AS NVARCHAR(10)) + 
		      ', Número: ' + CAST(@ErrorNumber AS NVARCHAR(10));

		THROW ;
		
		SELECT @codigo AS Codigo, @mensaje AS Mensaje;

	END CATCH 



	
END; 
