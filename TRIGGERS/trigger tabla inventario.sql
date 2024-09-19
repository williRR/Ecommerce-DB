USE abarroteria;
GO

-- Creación del para trigger controlar los datos cambiados en la tabla inventario
CREATE OR ALTER TRIGGER TR_UpdateInventario
ON inventario
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
    SET @TableName = 'inventario';

    -- Insertar cambios en la tabla de auditoría para cada columna actualizada
    IF UPDATE(codigo_inventario)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated codigo_inventario', @UserName, @TipoModificacion);

    IF UPDATE(fk_proveedor)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated fk_proveedor', @UserName, @TipoModificacion);

    IF UPDATE(cantidad_disponible)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated cantidad_disponible', @UserName, @TipoModificacion);

    IF UPDATE(precio_compra)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated precio_compra', @UserName, @TipoModificacion);

    IF UPDATE(fecha_abastecimiento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated fecha_abastecimiento', @UserName, @TipoModificacion);

    IF UPDATE(ubicacion)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated ubicacion', @UserName, @TipoModificacion);

    -- Actualizar la información de fecha y usuario de modificación en la tabla inventario
    UPDATE inventario
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE inventario.codigo_inventario = inserted.codigo_inventario; -- Reemplaza "codigo_inventario" con la clave primaria de tu tabla
END;
GO



-- Creación del trigger para prevenir la eliminación de registros en la tabla inventario
CREATE OR ALTER TRIGGER TR_DeleteInventario
ON inventario
INSTEAD OF DELETE
AS
BEGIN
    -- Verificamos que la eliminación no sea permitida
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS, SOLO ACTUALIZAR SU ESTADO';

END;
GO
