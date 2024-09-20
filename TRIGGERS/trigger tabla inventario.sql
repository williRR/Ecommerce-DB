USE abarroteria;
GO
-- Creaci�n del trigger para controlar los datos cambiados en la tabla inventario
CREATE OR ALTER TRIGGER TR_UpdateInventario
ON inventario
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
    SET @TableName = 'inventario';

    -- Insertar cambios en la tabla de auditor�a para cada columna actualizada

    -- Cambios en fk_proveedor
    IF UPDATE(fk_proveedor)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'fk_proveedor', @UserName, @TipoModificacion, i.codigo_inventario, i.fk_proveedor, d.fk_proveedor
        FROM inserted i
        JOIN deleted d ON i.codigo_inventario = d.codigo_inventario;

    -- Cambios en cantidad_disponible
    IF UPDATE(cantidad_disponible)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'cantidad_disponible', @UserName, @TipoModificacion, i.codigo_inventario, i.cantidad_disponible, d.cantidad_disponible
        FROM inserted i
        JOIN deleted d ON i.codigo_inventario = d.codigo_inventario;

    -- Cambios en precio_compra
    IF UPDATE(precio_compra)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'precio_compra', @UserName, @TipoModificacion, i.codigo_inventario, i.precio_compra, d.precio_compra
        FROM inserted i
        JOIN deleted d ON i.codigo_inventario = d.codigo_inventario;

    -- Cambios en fecha_abastecimiento
    IF UPDATE(fecha_abastecimiento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'fecha_abastecimiento', @UserName, @TipoModificacion, i.codigo_inventario, i.fecha_abastecimiento, d.fecha_abastecimiento
        FROM inserted i
        JOIN deleted d ON i.codigo_inventario = d.codigo_inventario;

    -- Cambios en ubicacion
    IF UPDATE(ubicacion)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion, id, valor_nuevo, valor_antiguo)
        SELECT @DateTime, @TableName, 'ubicacion', @UserName, @TipoModificacion, i.codigo_inventario, i.ubicacion, d.ubicacion
        FROM inserted i
        JOIN deleted d ON i.codigo_inventario = d.codigo_inventario;

    -- Actualizar la informaci�n de fecha y usuario de modificaci�n en la tabla inventario
    UPDATE inventario
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE inventario.codigo_inventario = inserted.codigo_inventario;

END;
GO



-- Creaci�n del trigger para prevenir la eliminaci�n de registros en la tabla inventario
CREATE OR ALTER TRIGGER TR_DeleteInventario
ON inventario
INSTEAD OF DELETE
AS
BEGIN
    -- Verificamos que la eliminaci�n no sea permitida
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS, SOLO ACTUALIZAR SU ESTADO';

END;
GO
