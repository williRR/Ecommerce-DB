USE abarroteria
GO 

-- Procedimiento para crear una nueva factura
CREATE OR ALTER PROCEDURE crearFacturaVenta
	@no_factura VARCHAR(50),
	@no_nit		VARCHAR(14),
	@nit_empresa VARCHAR(14),
	@codigo_empleado VARCHAR(14),
	@fecha DATETIME
AS
BEGIN 
	-- Iniciamos la transacción
	BEGIN TRANSACTION 

	-- Evitamos mensajes de conteo de filas afectadas
	SET NOCOUNT ON 
	
	BEGIN TRY
		-- Crear tabla temporal para almacenar la factura
		CREATE TABLE ##temporal_factura (
			no_factura VARCHAR(50),
			fk_nit_cliente VARCHAR(14),
			fk_empresa VARCHAR(14),
			fk_empleado VARCHAR(14),
			fecha DATE NOT NULL,
			monto_total DECIMAL(10, 2) NOT NULL DEFAULT(0.01)
		);

		-- Insertar datos en la tabla temporal
		INSERT INTO ##temporal_factura (no_factura, fk_nit_cliente, fk_empresa, fk_empleado, fecha)
		VALUES (@no_factura, @no_nit, @nit_empresa, @codigo_empleado, @fecha);

		-- Confirmar la transacción
		COMMIT TRANSACTION
	END TRY

	-- Manejo de errores
	BEGIN CATCH
		-- Si ocurre un error, revertimos la transacción
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		-- Capturamos y mostramos el error
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
		DECLARE @ErrorState INT = ERROR_STATE();

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END;



