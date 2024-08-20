use abarroteria
GO 

CREATE OR ALTER PROCEDURE sp_insertarPresentacion
	@capacidad VARCHAR(10) ,
	@unidad_envase VARCHAR(10),
	@descripcion VARCHAR(50)

AS
	

BEGIN 

	SET NOCOUNT ON

	BEGIN TRANSACTION 
		
	BEGIN TRY 
		-- verificar si ya existe 
	 IF EXISTS (
				SELECT 1
				FROM presentacion
				WHERE capacidad = @capacidad AND unidad_envase=@unidad_envase 
				)
		-- en dado caso esto mostrara un mensaje 
		BEGIN 
			 PRINT 'YA EN EXISTENCIA';
			 RETURN -- para salir de procedimiento 
		END;

	 ELSE 
	 -- si no existe ingresaremos los datos 
		BEGIN
			INSERT INTO presentacion (capacidad , unidad_envase, descripcion)
			VALUES (@capacidad, @unidad_envase,@descripcion);
			 PRINT 'Nueva presentación insertada exitosamente.';
		END ;
		
		COMMIT TRANSACTION ; -- confirmar si todo a salido bien 
	END TRY 


	-- manejo de errores 
	BEGIN CATCH
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
		

	END CATCH 



	
END; 
