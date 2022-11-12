-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, das eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank (erneut) anlegen und wechseln

:SETVAR dbname dotnetconsulting_StoredProcedures
USE [master];
IF EXISTS (SELECT * FROM [sys].[databases] WHERE [name] = '$(dbname)')
BEGIN
	ALTER DATABASE [$(dbname)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE [$(dbname)];
	PRINT '''$(dbname)''-Datenbank gel�scht';
END
GO
CREATE DATABASE [$(dbname)];
GO
USE [$(dbname)];
PRINT '''$(dbname)''-Datenbank erstellt und gewechselt';
GO

-- Stored Procedure anlegen
CREATE PROCEDURE [dbo].[usp_StoredProcedure_Errorhandling_LogErrorInfo]
AS
SELECT -- Details �ber den letzten Fehler ausgeben
     ERROR_NUMBER() AS ErrorNumber
    ,ERROR_SEVERITY() AS ErrorSeverity
    ,ERROR_STATE() AS ErrorState
    ,ERROR_PROCEDURE() AS ErrorProcedure
    ,ERROR_LINE() AS ErrorLine
    ,ERROR_MESSAGE() AS ErrorMessage;
GO

-- Stored Procedure anlegen
CREATE PROC [dbo].[usp_StoredProcedure_Errorhandling] 
AS
BEGIN	
	SET XACT_ABORT OFF;

	BEGIN TRY
		-- 'Nat�rlicher Fehler'
		 SELECT 1/0;

		-- 'K�nstliche' Fehler
		--THROW 50001, -- Fehlercode >= 50000
		--	  'Throw l�st einen Fehler aus', -- Fehlertext
		--	  1; -- State

		--RAISERROR ('RAISERROR l�st einen Fehler aus', -- Fehlertext
		--			11, -- Severity (Schweregrad) 11-19 ODER SETERROR werden vom CATCH-Block abgefangen
		--			1) -- State
		--			WITH LOG,			-- In das Serverlog schreiben
		--				 NOWAIT,		-- Sofort und ohne Verz�gerung an den Client schicken
		--				 SETERROR;		-- Unabh�ngig von Severity als Fehler betrachten
	END TRY
	BEGIN CATCH
		-- Fehler auf dem CATCH-Block schlagen hier auf
		-- Keine Syntax-Fehler!
		ROLLBACK TRANSACTION;

		BEGIN TRANSACTION
		IF @@Error != 0 --  Fehler vorhanden? Sollte so sein,aber das ist ja ein Demo
			EXECUTE [dbo].[usp_StoredProcedure_Errorhandling_LogErrorInfo];

		-- Fehler an Aufrufer 'hochreichen'?
		THROW;
	END CATCH
END;
GO

-- Aufruf

BEGIN TRANSACTION;

EXEC [dbo].[usp_StoredProcedure_Errorhandling]; 

COMMIT TRANSACTION;