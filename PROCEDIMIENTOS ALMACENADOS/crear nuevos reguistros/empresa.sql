USE ECOMMERCE ;
GO


-- PROCEDIMIENTO ALMACENADO PARA INGRESAR DATOS EMPRESA

CREATE OR ALTER PROCEDURE sp_InsertarEmpresa

	@nit VARCHAR(14),
	@nombre_comercial VARCHAR(50),
	@departamento VARCHAR(30),
	@municipio VARCHAR(25),
	@zona VARCHAR(25),
	@calle VARCHAR(25),
	@avenida VARCHAR(25),
	@telefono VARCHAR(10),
	@correo_electronico VARCHAR(50),
	

AS
BEGIN
	SET NOCOUNT ON 

	BEGIN TRANSACTION 
		BEGIN TRY
			-- VERIFICAR SI EL INSERT YA EXISTE 
			DECLARE @existEmpresa = 0 ;




			INSERT INTO empresa(nit,nombre_comercial,departamento,municipio,zona,calle,avenida,telefono,correo_electronico)
			VALUES (@nit )

		END TRY 

		BEGIN CATCH


		END CATCH 
	

		

	COMMIT 

	
END 
