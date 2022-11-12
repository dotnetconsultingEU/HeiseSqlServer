-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Es wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen steht der Autor gerne zur Verf�gung.
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
