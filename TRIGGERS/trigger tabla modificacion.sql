USE abarroteria
GO

-- Creación del trigger para prevenir la eliminación de registros en la tabla cliente
CREATE OR ALTER TRIGGER TR_DeleteModificacion
ON modificacion
INSTEAD OF DELETE 
AS
BEGIN
    -- Verificamos que la eliminación no sea permitida
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS EN LA TABLA MODIFICACION ';

END;
go

-- Creación del trigger para prevenir la eliminación de registros en la tabla cliente
CREATE OR ALTER TRIGGER TR_updateModificacion
ON modificacion
INSTEAD OF UPDATE 
AS
BEGIN
    -- Verificamos que la eliminación no sea permitida
    PRINT 'NO ES PERMITIDO ACTUALIZAR REGISTROS EN LA TABLA MODIFICACION ';

END;

