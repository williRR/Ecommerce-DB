USE abarroteria;
GO

-- Creación del trigger para controlar los datos cambiados en la tabla producto
CREATE OR ALTER TRIGGER TR_UpdateProducto
ON producto
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
    SET @TableName = 'producto';

    -- Insertar cambios en la tabla de auditoría para cada columna actualizada

    -- Cambios en fk_inventario
    IF UPDATE(fk_inventario)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'fk_inventario', @UserName, @TipoModificacion, i.codigo_producto, i.fk_inventario, d.fk_inventario
        FROM inserted i
        JOIN deleted d ON i.codigo_producto = d.codigo_producto;

    -- Cambios en nombre
    IF UPDATE(nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'nombre', @UserName, @TipoModificacion, i.codigo_producto, i.nombre, d.nombre
        FROM inserted i
        JOIN deleted d ON i.codigo_producto = d.codigo_producto;

    -- Cambios en fk_presentacion
    IF UPDATE(fk_presentacion)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'fk_presentacion', @UserName, @TipoModificacion, i.codigo_producto, i.fk_presentacion, d.fk_presentacion
        FROM inserted i
        JOIN deleted d ON i.codigo_producto = d.codigo_producto;

    -- Cambios en precio_unitario
    IF UPDATE(precio_unitario)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'precio_unitario', @UserName, @TipoModificacion, i.codigo_producto, i.precio_unitario, d.precio_unitario
        FROM inserted i
        JOIN deleted d ON i.codigo_producto = d.codigo_producto;

    -- Cambios en fecha_entrada
    IF UPDATE(fecha_entrada)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'fecha_entrada', @UserName, @TipoModificacion, i.codigo_producto, i.fecha_entrada, d.fecha_entrada
        FROM inserted i
        JOIN deleted d ON i.codigo_producto = d.codigo_producto;

    -- Cambios en fecha_vencimiento
    IF UPDATE(fecha_vencimiento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'fecha_vencimiento', @UserName, @TipoModificacion, i.codigo_producto, i.fecha_vencimiento, d.fecha_vencimiento
        FROM inserted i
        JOIN deleted d ON i.codigo_producto = d.codigo_producto;

    -- Cambios en marca
    IF UPDATE(marca)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'marca', @UserName, @TipoModificacion, i.codigo_producto, i.marca, d.marca
        FROM inserted i
        JOIN deleted d ON i.codigo_producto = d.codigo_producto;

    -- Actualizar la información de fecha y usuario de modificación en la tabla producto
    UPDATE producto
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE producto.codigo_producto = inserted.codigo_producto; -- Reemplaza "codigo_producto" con la clave primaria de tu tabla

END;
GO




-- Creación del trigger para prevenir la eliminación de registros en la tabla producto
CREATE OR ALTER TRIGGER TR_DeleteProducto
ON producto
INSTEAD OF DELETE
AS
BEGIN
    -- Verificamos que la eliminación no sea permitida
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS, SOLO ACTUALIZAR SU ESTADO';


END;
GO
