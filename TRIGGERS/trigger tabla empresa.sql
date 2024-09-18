USE abarroteria;
GO

-- Creaci�n del trigger para controlar los datos cambiados en la tabla empresa
CREATE OR ALTER TRIGGER TR_UpdateEmpresa
ON empresa
FOR UPDATE
AS
BEGIN
    -- Declaramos estas variables para insertarlas m�s adelante en la tabla modificacion
    DECLARE @DateTime DATETIME; -- Guardaremos la fecha y hora
    DECLARE @UserName NVARCHAR(100); -- Se guardar� el usuario que efectu� la actualizaci�n
    DECLARE @TableName NVARCHAR(20); -- Indicaremos la tabla que se afect�
    DECLARE @TipoModificacion VARCHAR(20) = 'ACTUALIZACION'; -- Indicaremos el tipo de modificaci�n
    
    SET @DateTime = GETDATE();
    SET @UserName = SUSER_SNAME();
    SET @TableName = 'empresa';

    -- Insertar cambios en la tabla de auditor�a para cada columna actualizada
    IF UPDATE(nombre_comercial)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated nombre_comercial', @UserName, @TipoModificacion);

    IF UPDATE(departamento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated departamento', @UserName, @TipoModificacion);

    IF UPDATE(municipio)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated municipio', @UserName, @TipoModificacion);

    IF UPDATE(zona)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated zona', @UserName, @TipoModificacion);

    IF UPDATE(calle)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated calle', @UserName, @TipoModificacion);

    IF UPDATE(avenida)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated avenida', @UserName, @TipoModificacion);

    IF UPDATE(telefono)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated telefono', @UserName, @TipoModificacion);

    IF UPDATE(correo_electronico)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated correo_electronico', @UserName, @TipoModificacion);

    -- Actualizar la informaci�n de fecha y usuario de modificaci�n en la tabla empresa
    UPDATE empresa
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE empresa.nit = inserted.nit; -- Reemplaza "nit" con la clave primaria de tu tabla
END;
GO



-- Creaci�n del trigger para prevenir la eliminaci�n de registros en la tabla empresa
CREATE OR ALTER TRIGGER TR_DeleteEmpresa
ON empresa
INSTEAD OF DELETE
AS
BEGIN
    -- Verificamos que la eliminaci�n no sea permitida
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS, SOLO ACTUALIZAR SU ESTADO';


END;
GO
