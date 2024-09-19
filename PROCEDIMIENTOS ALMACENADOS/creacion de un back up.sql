CREATE OR ALTER PROCEDURE GenerarBackupAbarroteria
AS
BEGIN
    BEGIN TRY
        -- Iniciar respaldo de la base de datos abarroteria
        BACKUP DATABASE [abarroteria] 
        TO DISK = N'C:\bakup\Bk_abarroteria.bak'
        WITH NOFORMAT, INIT,  
        NAME = N'abarroteria-Full Database Backup', 
        SKIP, NOREWIND, NOUNLOAD,  
        STATS = 10;

        PRINT 'Respaldo de la base de datos abarroteria completado exitosamente.';
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        -- Obtener detalles del error
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Mostrar el error
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
