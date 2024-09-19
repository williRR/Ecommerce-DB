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
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'nombre', @UserName, @TipoModificacion, i.nit, i.nombre, d.nombre
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    IF UPDATE(apellido)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'apellido', @UserName, @TipoModificacion, i.nit, i.apellido, d.apellido
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    IF UPDATE(correo_electronico)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'correo_electronico', @UserName, @TipoModificacion, i.nit, i.correo_electronico, d.correo_electronico
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    IF UPDATE(telefono)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'telefono', @UserName, @TipoModificacion, i.nit, i.telefono, d.telefono
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    IF UPDATE(nacimiento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'nacimiento', @UserName, @TipoModificacion, i.nit, i.nacimiento, d.nacimiento
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    IF UPDATE(genero)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'genero', @UserName, @TipoModificacion, i.nit, i.genero, d.genero
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    IF UPDATE(direccion)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'direccion', @UserName, @TipoModificacion, i.nit, i.direccion, d.direccion
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;
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


