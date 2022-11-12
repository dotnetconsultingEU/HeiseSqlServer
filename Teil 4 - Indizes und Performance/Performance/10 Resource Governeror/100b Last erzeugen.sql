use [Sql2014PocBigBoy];
EXEC sp_msForEachTable 'DBCC DROPCLEANBUFFERS; Select * from ?';