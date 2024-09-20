USE abarroteria
GO 


CREATE OR ALTER PROCEDURE InsertarProductosFactura 
	@no_factura  VARCHAR(50),
	@codigo_producto VARCHAR(14),
	@cantidad	INT 
AS
BEGIN
	BEGIN TRY
		-- Iniciar la transaccion
		BEGIN TRANSACTION 

		-- Evitar mostrar el numero de filas afectadas
		SET NOCOUNT ON 

		-- Crear la tabla temporal si no existe
		IF OBJECT_ID('tempdb..##temporalDetalleFactura') IS NULL
		BEGIN
			CREATE TABLE ##temporalDetalleFactura (
				fk_no_factura VARCHAR(50),
				fk_codigo_producto VARCHAR(14),
				nombre_producto VARCHAR(50) NOT NULL,
				cantidad INT CHECK(cantidad >= 1) NOT NULL,
				precio_unitario DECIMAL(10,2) NOT NULL,
				subtotal DECIMAL(10,2) NOT NULL
			);
		END

		-- Variables para capturar los datos de la tabla producto
		DECLARE @precio_unitario DECIMAL(10,2);
		DECLARE @nombre_producto VARCHAR(50);

		-- Obtener el precio unitario y el nombre del producto de la tabla 'producto'
		SELECT 
			@precio_unitario = precio_unitario, 
			@nombre_producto = nombre
		FROM producto 
		WHERE codigo_producto = @codigo_producto;

		-- Si no se encuentra el producto, lanzar un error
		IF @precio_unitario IS NULL OR @nombre_producto IS NULL
		BEGIN
			THROW 50000, 'Producto no encontrado.', 1;
		
		END

		-- Calcular el subtotal
		DECLARE @subtotal DECIMAL(10,2) = @cantidad * @precio_unitario;

		-- Insertar los datos en la tabla temporal
		INSERT INTO ##temporalDetalleFactura 
			(fk_no_factura, fk_codigo_producto, nombre_producto, cantidad, precio_unitario, subtotal)
		VALUES 
			(@no_factura, @codigo_producto, @nombre_producto, @cantidad, @precio_unitario, @subtotal);

		-- Confirmar la transacción
		COMMIT TRANSACTION 
	END TRY

	BEGIN CATCH
		-- Si ocurre un error, revertir la transacción
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		-- Capturar y mostrar el error
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
		DECLARE @ErrorState INT = ERROR_STATE();

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END;
