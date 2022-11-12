-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, das eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank wechseln
USE [dotnetconsulting_Videogames];
GO

-- Stored Procedure ggf löschen
IF NOT OBJECT_ID('[dbo].[usp_StoredProcedure_Cursor]', 'P') IS NULL
	DROP PROCEDURE [dbo].[usp_StoredProcedure_Cursor];
GO

-- Stored Procedure anlegen
CREATE PROCEDURE [dbo].[usp_StoredProcedure_Cursor]
AS
BEGIN
    SET NOCOUNT ON;

	-- Variable für äußeren Cursor
	DECLARE [spieler_cursor] CURSOR LOCAL FORWARD_ONLY READ_ONLY
        FOR
        SELECT  [ID],
                [Name]
        FROM    [dbo].[Spieler]
        WHERE   [Aktiv] = 1
        ORDER BY [ID];

    BEGIN TRY
        DECLARE @spieler_ID INT,
				@spieler_name NVARCHAR(50),
				@message VARCHAR(80),
				@highscore INT,
				@spiel_name VARCHAR(50);

        PRINT '-------- Highscore Report --------';

		-- Cursor öffnen
        OPEN [spieler_cursor];
		
		-- Cursor auf erste Zeile positionieren
        FETCH NEXT FROM [spieler_cursor] INTO @spieler_ID, @spieler_name;

        WHILE @@FETCH_STATUS = 0
            BEGIN				
                PRINT ' ';
                SELECT  @message = '----- Highscore von : ' + @spieler_name;

                PRINT @message;

				-- Variable für inneren Cursor
                DECLARE [highscore_cursor] CURSOR
                FOR
                SELECT  [hs].[Punkte], [vs].[Name] FROM [dbo].[Highscores] [hs]
				INNER JOIN [dbo].[Videospiele] [vs] ON [hs].[VideospielID] = [vs].[ID]
				WHERE [SpielerID] = @spieler_ID
				ORDER BY [hs].[Punkte] DESC;

				BEGIN TRY
					-- Inneren Cursor öffnen
					OPEN [highscore_cursor];

					-- Cursor auf erste Zeile positionieren
					FETCH NEXT FROM [highscore_cursor] INTO @highscore, @spiel_name;

					IF @@FETCH_STATUS <> 0
						PRINT '         <<None>>';     

					WHILE @@FETCH_STATUS = 0
						BEGIN
							-- Ausgabe
							SELECT  @message = CONCAT('         ', @highscore, ' ', @spiel_name);
							PRINT @message;

							-- Nächste (innere) Zeile
							FETCH NEXT FROM [highscore_cursor] INTO @highscore, @spiel_name;
						END;
					-- Cursor schließen
					CLOSE [highscore_cursor];
					DEALLOCATE [highscore_cursor];
				END TRY
				BEGIN CATCH
					PRINT 'Fehler im inneren Cursor';
					
					-- Cursor schließen
					CLOSE [highscore_cursor];
					DEALLOCATE [highscore_cursor];
					
					-- Fehler weiterreichen in den äußeren CATCH-Block
					THROW;
				END CATCH

				-- Nächste (äußere) Zeile
                FETCH NEXT FROM [spieler_cursor] INTO @spieler_ID, @spieler_name;
            END; 
        CLOSE [spieler_cursor];
        DEALLOCATE [spieler_cursor];
    END TRY
    BEGIN CATCH
		PRINT 'Fehler im äußeren Cursor';

		-- Cursor schließen
	    CLOSE [spieler_cursor];
        DEALLOCATE [spieler_cursor];

		-- Details über den letzten Fehler ausgeben/ loggen
        SELECT 
                ERROR_NUMBER() AS [ErrorNumber],
                ERROR_SEVERITY() AS [ErrorSeverity],
                ERROR_STATE() AS [ErrorState],
                ERROR_PROCEDURE() AS [ErrorProcedure],
                ERROR_LINE() AS [ErrorLine],
                ERROR_MESSAGE() AS [ErrorMessage];
		THROW;
    END CATCH;
END;
GO

-- Aufruf
EXEC [dbo].[usp_StoredProcedure_Cursor]; 
