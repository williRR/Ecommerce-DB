USE abarroteria;
GO 

-- Creación del trigger para controlar los datos cambiados en la tabla proveedor
CREATE OR ALTER TRIGGER TR_UpdateProveedor
ON proveedor
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
    SET @TableName = 'proveedor';

    -- Insertar cambios en la tabla de auditoría para cada columna actualizada

    IF UPDATE(nombre_empresa)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'nombre_empresa', @UserName, @TipoModificacion, i.codigo_proveedor, i.nombre_empresa, d.nombre_empresa
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(primer_nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'primer_nombre', @UserName, @TipoModificacion, i.codigo_proveedor, i.primer_nombre, d.primer_nombre
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(segundo_nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'segundo_nombre', @UserName, @TipoModificacion, i.codigo_proveedor, i.segundo_nombre, d.segundo_nombre
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(primer_apellido)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'primer_apellido', @UserName, @TipoModificacion, i.codigo_proveedor, i.primer_apellido, d.primer_apellido
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(segundo_apellido)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'segundo_apellido', @UserName, @TipoModificacion, i.codigo_proveedor, i.segundo_apellido, d.segundo_apellido
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(fecha_comienzo_relacion)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'fecha_comienzo_relacion', @UserName, @TipoModificacion, i.codigo_proveedor, i.fecha_comienzo_relacion, d.fecha_comienzo_relacion
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(correo_electronico)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'correo_electronico', @UserName, @TipoModificacion, i.codigo_proveedor, i.correo_electronico, d.correo_electronico
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(telefono)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'telefono', @UserName, @TipoModificacion, i.codigo_proveedor, i.telefono, d.telefono
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(telefono_fijo)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'telefono_fijo', @UserName, @TipoModificacion, i.codigo_proveedor, i.telefono_fijo, d.telefono_fijo
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(departamento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'departamento', @UserName, @TipoModificacion, i.codigo_proveedor, i.departamento, d.departamento
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(municipio)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'municipio', @UserName, @TipoModificacion, i.codigo_proveedor, i.municipio, d.municipio
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(zona)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'zona', @UserName, @TipoModificacion, i.codigo_proveedor, i.zona, d.zona
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(calle)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'calle', @UserName, @TipoModificacion, i.codigo_proveedor, i.calle, d.calle
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    IF UPDATE(avenida)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'avenida', @UserName, @TipoModificacion, i.codigo_proveedor, i.avenida, d.avenida
        FROM inserted i
        JOIN deleted d ON i.codigo_proveedor = d.codigo_proveedor;

    -- Actualizar la información de fecha y usuario de modificación en la tabla proveedor
    UPDATE proveedor
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE proveedor.codigo_proveedor = inserted.codigo_proveedor; -- Reemplaza "codigo_proveedor" con la clave primaria de tu tabla

END;
GO




-- Se usará un INSTEAD OF ya que no se permitirá la eliminación de estos registros
CREATE OR ALTER TRIGGER TR_deleteProveedor
ON proveedor 
INSTEAD OF DELETE
AS
BEGIN
	set nocount on 
    -- Verificamos que el registro exista
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS, SOLO ACTUALIZAR SU ESTADO';
END;
GO

select * from modificacion

update 
