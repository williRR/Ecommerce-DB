USE abarroteria;
GO 

-- Creaci�n del trigger para controlar los datos cambiados
CREATE OR ALTER TRIGGER TR_UpdateProveedor
ON proveedor
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
    SET @TableName = 'proveedor';

    -- Insertar cambios en la tabla de auditor�a para cada columna actualizada


    IF UPDATE(nombre_empresa)

	/* se puede notar que hay muchos querys que insertan datos , esto se hace con el fin en que si se actualiza varios 
		datos , se tenga reguistro todos los datos actualizados 
	*/
	
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated nombre_empresa', @UserName, @TipoModificacion);

    IF UPDATE(primer_nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated primer_nombre', @UserName, @TipoModificacion);

    IF UPDATE(segundo_nombre)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated segundo_nombre', @UserName, @TipoModificacion);

    IF UPDATE(primer_apellido)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated primer_apellido', @UserName, @TipoModificacion);

    IF UPDATE(segundo_apellido)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated segundo_apellido', @UserName, @TipoModificacion);

    IF UPDATE(fecha_comienzo_relacion)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated fecha_comienzo_relacion', @UserName, @TipoModificacion);

    IF UPDATE(correo_electronico)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated correo_electronico', @UserName, @TipoModificacion);

    IF UPDATE(telefono)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated telefono', @UserName, @TipoModificacion);

    IF UPDATE(telefono_fijo)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated telefono_fijo', @UserName, @TipoModificacion);

    IF UPDATE(departamento)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated departamento', @UserName, @TipoModificacion);

    IF UPDATE(municipio)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated municipio', @UserName, @TipoModificacion);

    IF UPDATE(zona)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated zona', @UserName, @TipoModificacion);

    IF UPDATE(calle)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated calle', @UserName, @TipoModificacion);

    IF UPDATE(avenida)
        INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
        VALUES (@DateTime, @TableName, 'Updated avenida', @UserName, @TipoModificacion);

    -- Actualizar la informaci�n de fecha y usuario de modificaci�n en la tabla proveedor
    UPDATE proveedor
    SET fecha_modificacion = @DateTime
    FROM inserted
    WHERE proveedor.codigo_proveedor = inserted.codigo_proveedor; -- Reemplaza "codigo_proveedor" con la clave primaria de tu tabla

END;
GO






-- Se usar� un INSTEAD OF ya que no se permitir� la eliminaci�n de estos registros
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


