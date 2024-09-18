USE abarroteria;
GO

-- Creaci�n del trigger para controlar los datos cambiados en la tabla producto
CREATE OR ALTER TRIGGER TR_UpdateProducto
ON producto
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
    SET @TableName = 'producto';

    -- Insertar cambios en la tabla de auditor�a para cada columna actualizada
    IF UPDATE(fk_inventario)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated fk_inventario', @UserName, @TipoModificacion);

    IF UPDATE(fk_presentacion)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated fk_presentacion', @UserName, @TipoModificacion);

    IF UPDATE(precio_unitario)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated precio_unitario', @UserName, @TipoModificacion);

    IF UPDATE(fecha_entrada)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated fecha_entrada', @UserName, @TipoModificacion);

    IF UPDATE(fecha_vencimiento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated fecha_vencimiento', @UserName, @TipoModificacion);

    IF UPDATE(marca)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated marca', @UserName, @TipoModificacion);

    -- Actualizar la informaci�n de fecha y usuario de modificaci�n en la tabla producto
    UPDATE producto
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE producto.codigo_producto = inserted.codigo_producto; -- Reemplaza "codigo_producto" con la clave primaria de tu tabla
END;
GO




-- Creaci�n del trigger para prevenir la eliminaci�n de registros en la tabla producto
CREATE OR ALTER TRIGGER TR_DeleteProducto
ON producto
INSTEAD OF DELETE
AS
BEGIN
    -- Verificamos que la eliminaci�n no sea permitida
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS, SOLO ACTUALIZAR SU ESTADO';


END;
GO
