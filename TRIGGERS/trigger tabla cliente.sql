USE abarroteria;
GO

-- Creación del trigger para controlar los datos cambiados en la tabla cliente
CREATE OR ALTER TRIGGER TR_UpdateCliente
ON cliente
FOR UPDATE
AS
BEGIN
    -- Declaramos estas variables para insertarlas más adelante en la tabla modificacion
    DECLARE @DateTime DATETIME; -- Guardaremos la fecha y hora
    DECLARE @UserName NVARCHAR(100); -- Se guardará el usuario que efectuó la actualización
    DECLARE @TableName NVARCHAR(20); -- Indicaremos la tabla que se afectó
    DECLARE @TipoModificacion VARCHAR(20) = 'ACTUALIZACION'; -- Indicaremos el tipo de modificación
    
    SET @DateTime = GETDATE();
    SET @UserName = SUSER_SNAME();
    SET @TableName = 'cliente';

    -- Insertar cambios en la tabla de auditoría para cada columna actualizada
    IF UPDATE(nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated nombre', @UserName, @TipoModificacion);

    IF UPDATE(apellido)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated apellido', @UserName, @TipoModificacion);

    IF UPDATE(correo_electronico)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated correo_electronico', @UserName, @TipoModificacion);

    IF UPDATE(telefono)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated telefono', @UserName, @TipoModificacion);

    IF UPDATE(nacimiento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated nacimiento', @UserName, @TipoModificacion);

    IF UPDATE(genero)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated genero', @UserName, @TipoModificacion);

    IF UPDATE(direccion)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated direccion', @UserName, @TipoModificacion);

    -- Actualizar la información de fecha y usuario de modificación en la tabla cliente
    UPDATE cliente
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE cliente.nit = inserted.nit; -- Reemplaza "nit" con la clave primaria de tu tabla
END;
GO





-- Creación del trigger para prevenir la eliminación de registros en la tabla cliente
CREATE OR ALTER TRIGGER TR_DeleteCliente
ON cliente
INSTEAD OF DELETE
AS
BEGIN
    -- Verificamos que la eliminación no sea permitida
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS, SOLO ACTUALIZAR SU ESTADO';

END;
GO
