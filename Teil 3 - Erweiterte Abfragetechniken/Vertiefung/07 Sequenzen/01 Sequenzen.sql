-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- In Datenbank wechseln
USE dotnetconsulting_TSQL2;
GO

CREATE SEQUENCE MeineSequenz
    AS INT
    MINVALUE 1
    NO MAXVALUE
    INCREMENT BY 3
    START WITH 1;
GO

SELECT * FROM sys.sequences;

DECLARE @id INT = NEXT VALUE FOR MeineSequenz;

DECLARE @firstValue SQL_VARIANT, 
        @lastValue SQL_VARIANT;

EXEC sys.sp_sequence_get_range
    @sequence_name = 'MeineSequenz',
    @range_size = 12,
    @range_first_value = @firstValue OUTPUT,
    @range_last_value = @lastValue OUTPUT;

SELECT FirstValue = CONVERT(INT, @firstValue),
       LastVlaue = CONVERT(INT, @lastValue);
