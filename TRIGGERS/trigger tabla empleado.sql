USE abarroteria;
GO

-- Creaci�n del trigger para controlar los datos cambiados en la tabla empleado
CREATE OR ALTER TRIGGER TR_UpdateEmpleado
ON empleado
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
    SET @TableName = 'empleado';

    -- Insertar cambios en la tabla de auditor�a para cada columna actualizada
    IF UPDATE(dni)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated dni', @UserName, @TipoModificacion);

    IF UPDATE(primer_nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated primer_nombre', @UserName, @TipoModificacion);

    IF UPDATE(segundo_nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated segundo_nombre', @UserName, @TipoModificacion);

    IF UPDATE(tercer_nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated tercer_nombre', @UserName, @TipoModificacion);

    IF UPDATE(primer_apellido)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated primer_apellido', @UserName, @TipoModificacion);

    IF UPDATE(segundo_apellido)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated segundo_apellido', @UserName, @TipoModificacion);

    IF UPDATE(apellido_casada)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated apellido_casada', @UserName, @TipoModificacion);

    IF UPDATE(direccion)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated direccion', @UserName, @TipoModificacion);

    IF UPDATE(correo_electronico)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated correo_electronico', @UserName, @TipoModificacion);

    IF UPDATE(telefono)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated telefono', @UserName, @TipoModificacion);

    IF UPDATE(fecha_alta)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated fecha_alta', @UserName, @TipoModificacion);

    IF UPDATE(fecha_baja)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated fecha_baja', @UserName, @TipoModificacion);

    IF UPDATE(genero)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated genero', @UserName, @TipoModificacion);

    IF UPDATE(nacimiento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated nacimiento', @UserName, @TipoModificacion);

    -- Actualizar la informaci�n de fecha y usuario de modificaci�n en la tabla empleado
    UPDATE empleado
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE empleado.codigo_empleado = inserted.codigo_empleado; -- Reemplaza "codigo_empleado" con la clave primaria de tu tabla
END;
GO




-- Creaci�n del trigger para prevenir la eliminaci�n de registros en la tabla empleado
CREATE OR ALTER TRIGGER TR_DeleteEmpleado
ON empleado
INSTEAD OF DELETE
AS
BEGIN
    -- Verificamos que la eliminaci�n no sea permitida
    PRINT 'NO ES PERMITIDO ELIMINAR REGISTROS, SOLO ACTUALIZAR SU ESTADO';


END;
GO


