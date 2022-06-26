/**********************************************************************
	TRY ... CATCH használata tranzakciókezelés nélkül
**********************************************************************/
	DECLARE @Oszto int = 0, @Osztando int = 20
	BEGIN TRY
		SELECT 'Ez még megjelenik'
		SELECT 'Itt nincs értelme meghívni, mert üreset ad vissza: ', ERROR_MESSAGE()
		SELECT @Osztando / @Oszto
		SELECT 'Ez már nem jelenik meg'
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_LINE(), ERROR_PROCEDURE(), 
			   ERROR_SEVERITY(), ERROR_STATE()   
	END CATCH
	SELECT 'Itt sincs értelme meghívni, mert üreset ad vissza: ', ERROR_MESSAGE()
	GO

/**********************************************************************
	TRY ... CATCH használata tranzakciókezeléssel
**********************************************************************/
	
	BEGIN TRAN	
	BEGIN TRY
		 -- SQL utasítás sorozat
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		-- INSERT db.ErrorLog (ErrorMsg, ErrorNumber, ErrorLine, ErrorProc, ErrorSeverity, ErrorState)
		SELECT ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_LINE(), ERROR_PROCEDURE(), 
			   ERROR_SEVERITY(), ERROR_STATE()
	END CATCH

/**********************************************************************
	Hibakezelés és tranzakciókezelés együtt
**********************************************************************/

	BEGIN TRY
		BEGIN TRAN
			-- SQL utasítás sorozat
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT ERROR_NUMBER(), ERROR_MESSAGE()
		IF XACT_STATE() <> 0 ROLLBACK TRAN 
	END CATCH

