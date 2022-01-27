CREATE TABLE [dbo].[ErrorLog](
    [ErrorLogID] [int] IDENTITY(1,1) NOT NULL,
    [ErrorTime] [datetime] NOT NULL,
    [UserName] [sysname] NOT NULL,
    [ErrorNumber] [int] NOT NULL,
    [ErrorSeverity] [int] NULL,
    [ErrorState] [int] NULL,
    [ErrorProcedure] [nvarchar](126) NULL,
    [ErrorLine] [int] NULL,
    [ErrorMessage] [nvarchar](4000) NOT NULL

    CONSTRAINT PK_ErrorLogID PRIMARY KEY (ErrorLogID)
 )
GO

CREATE PROCEDURE dbo.NewProcedure
    (
     -- paraméterek
    @FilmTitle nvarchar(100),
    @Genre nvarchar(100)
    )
AS
BEGIN
    BEGIN TRAN    
    BEGIN TRY
         -- SQL utasítás sorozat
         DECLARE @newmovieID int
        INSERT INTO movies VALUES (@FilmTitle)
        SELECT @newmovieID = @@IDENTITY

        DECLARE @newgenreID int
        INSERT INTO genres VALUES (@Genre)
        SELECT @newgenreID = @@IDENTITY

    INSERT INTO movieandgenre VALUES (@newmovieID,@newgenreID)
    
        COMMIT TRAN
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
        -- INSERT db.ErrorLog (ErrorMsg, ErrorNumber, ErrorLine, ErrorProc, ErrorSeverity, ErrorState)
        SELECT ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_LINE(), ERROR_PROCEDURE(), 
               ERROR_SEVERITY(), ERROR_STATE();
        INSERT INTO ErrorLog (ErrorTime,UserName,ErrorNumber,ErrorSeverity,ErrorState,ErrorProcedure,ErrorLine,ErrorMessage) 
        VALUES (GETDATE(),SUSER_NAME(),ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(), ERROR_LINE(), ERROR_MESSAGE())
    END CATCH
END;

EXEC NewProcedure 'sdfsfsgd',''

SELECT * FROM ErrorLog