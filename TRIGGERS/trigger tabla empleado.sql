USE abarroteria;
GO
-- Creación del trigger para controlar los datos cambiados en la tabla empleado
CREATE OR ALTER TRIGGER TR_UpdateEmpleado
ON empleado
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
    SET @TableName = 'empleado';

    -- Insertar cambios en la tabla de auditoría para cada columna actualizada

    -- Cambios en dni
    IF UPDATE(dni)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'dni', @UserName, @TipoModificacion, i.codigo_empleado, i.dni, d.dni
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en primer_nombre
    IF UPDATE(primer_nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'primer_nombre', @UserName, @TipoModificacion, i.codigo_empleado, i.primer_nombre, d.primer_nombre
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en segundo_nombre
    IF UPDATE(segundo_nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'segundo_nombre', @UserName, @TipoModificacion, i.codigo_empleado, i.segundo_nombre, d.segundo_nombre
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en tercer_nombre
    IF UPDATE(tercer_nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'tercer_nombre', @UserName, @TipoModificacion, i.codigo_empleado, i.tercer_nombre, d.tercer_nombre
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en primer_apellido
    IF UPDATE(primer_apellido)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'primer_apellido', @UserName, @TipoModificacion, i.codigo_empleado, i.primer_apellido, d.primer_apellido
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en segundo_apellido
    IF UPDATE(segundo_apellido)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'segundo_apellido', @UserName, @TipoModificacion, i.codigo_empleado, i.segundo_apellido, d.segundo_apellido
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en apellido_casada
    IF UPDATE(apellido_casada)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'apellido_casada', @UserName, @TipoModificacion, i.codigo_empleado, i.apellido_casada, d.apellido_casada
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en direccion
    IF UPDATE(direccion)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'direccion', @UserName, @TipoModificacion, i.codigo_empleado, i.direccion, d.direccion
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en correo_electronico
    IF UPDATE(correo_electronico)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'correo_electronico', @UserName, @TipoModificacion, i.codigo_empleado, i.correo_electronico, d.correo_electronico
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en telefono
    IF UPDATE(telefono)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'telefono', @UserName, @TipoModificacion, i.codigo_empleado, i.telefono, d.telefono
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en fecha_alta
    IF UPDATE(fecha_alta)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'fecha_alta', @UserName, @TipoModificacion, i.codigo_empleado, i.fecha_alta, d.fecha_alta
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en fecha_baja
    IF UPDATE(fecha_baja)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'fecha_baja', @UserName, @TipoModificacion, i.codigo_empleado, i.fecha_baja, d.fecha_baja
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en genero
    IF UPDATE(genero)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'genero', @UserName, @TipoModificacion, i.codigo_empleado, i.genero, d.genero
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Cambios en nacimiento
    IF UPDATE(nacimiento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'nacimiento', @UserName, @TipoModificacion, i.codigo_empleado, i.nacimiento, d.nacimiento
        FROM inserted i
        JOIN deleted d ON i.codigo_empleado = d.codigo_empleado;

    -- Actualizar la información de fecha y usuario de modificación en la tabla empleado
    UPDATE empleado
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE empleado.codigo_empleado = inserted.codigo_empleado; -- Reemplaza "codigo_empleado" con la clave primaria de tu tabla

END;
GO




-- Creación del trigger para prevenir la eliminación de registros en la tabla empleado
CREATE OR ALTER TRIGGER TR_DeleteEmpleado
ON empleado
INSTEAD OF DELETE
AS
BEGIN
    -- Verificamos que la eliminación no sea permitida
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS, SOLO ACTUALIZAR SU ESTADO';


END;
GO




update empleado
set correo_electronico= 'willi@gmail.com',
segundo_apellido = 'roquel'
where codigo_empleado = 'EMP001'

select * from empleado


