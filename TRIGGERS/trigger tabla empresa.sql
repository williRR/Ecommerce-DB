USE abarroteria;
GO
-- Creación del trigger para controlar los datos cambiados en la tabla empresa
CREATE OR ALTER TRIGGER TR_UpdateEmpresa
ON empresa
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
    SET @TableName = 'empresa';

    -- Insertar cambios en la tabla de auditoría para cada columna actualizada

    -- Cambios en nombre_comercial
    IF UPDATE(nombre_comercial)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'nombre_comercial', @UserName, @TipoModificacion, i.nit, i.nombre_comercial, d.nombre_comercial
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    -- Cambios en departamento
    IF UPDATE(departamento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'departamento', @UserName, @TipoModificacion, i.nit, i.departamento, d.departamento
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    -- Cambios en municipio
    IF UPDATE(municipio)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'municipio', @UserName, @TipoModificacion, i.nit, i.municipio, d.municipio
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    -- Cambios en zona
    IF UPDATE(zona)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'zona', @UserName, @TipoModificacion, i.nit, i.zona, d.zona
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    -- Cambios en calle
    IF UPDATE(calle)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'calle', @UserName, @TipoModificacion, i.nit, i.calle, d.calle
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    -- Cambios en avenida
    IF UPDATE(avenida)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'avenida', @UserName, @TipoModificacion, i.nit, i.avenida, d.avenida
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    -- Cambios en telefono
    IF UPDATE(telefono)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'telefono', @UserName, @TipoModificacion, i.nit, i.telefono, d.telefono
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    -- Cambios en correo_electronico
    IF UPDATE(correo_electronico)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'correo_electronico', @UserName, @TipoModificacion, i.nit, i.correo_electronico, d.correo_electronico
        FROM inserted i
        JOIN deleted d ON i.nit = d.nit;

    -- Actualizar la información de fecha y usuario de modificación en la tabla empresa
    UPDATE empresa
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE empresa.nit = inserted.nit; -- Reemplaza "nit" con la clave primaria de tu tabla

END;
GO



-- Creación del trigger para prevenir la eliminación de registros en la tabla empresa
CREATE OR ALTER TRIGGER TR_DeleteEmpresa
ON empresa
INSTEAD OF DELETE
AS
BEGIN
    -- Verificamos que la eliminación no sea permitida
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS, SOLO ACTUALIZAR SU ESTADO';


END;
GO
