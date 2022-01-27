/**********************************************************************
	TRY ... CATCH haszn�lata tranzakci�kezel�s n�lk�l
**********************************************************************/
	DECLARE @Oszto int = 0, @Osztando int = 20
	BEGIN TRY
		SELECT 'Ez m�g megjelenik'
		SELECT 'Itt nincs �rtelme megh�vni, mert �reset ad vissza: ', ERROR_MESSAGE()
		SELECT @Osztando / @Oszto
		SELECT 'Ez m�r nem jelenik meg'
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_LINE(), ERROR_PROCEDURE(), 
			   ERROR_SEVERITY(), ERROR_STATE()   
	END CATCH
	SELECT 'Itt sincs �rtelme megh�vni, mert �reset ad vissza: ', ERROR_MESSAGE()
	GO

/**********************************************************************
	TRY ... CATCH haszn�lata tranzakci�kezel�ssel
**********************************************************************/
	
	BEGIN TRAN	
	BEGIN TRY
		 -- SQL utas�t�s sorozat
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		-- INSERT db.ErrorLog (ErrorMsg, ErrorNumber, ErrorLine, ErrorProc, ErrorSeverity, ErrorState)
		SELECT ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_LINE(), ERROR_PROCEDURE(), 
			   ERROR_SEVERITY(), ERROR_STATE()
	END CATCH

/**********************************************************************
	Hibakezel�s �s tranzakci�kezel�s egy�tt
**********************************************************************/

	BEGIN TRY
		BEGIN TRAN
			-- SQL utas�t�s sorozat
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT ERROR_NUMBER(), ERROR_MESSAGE()
		IF XACT_STATE() <> 0 ROLLBACK TRAN 
	END CATCH

