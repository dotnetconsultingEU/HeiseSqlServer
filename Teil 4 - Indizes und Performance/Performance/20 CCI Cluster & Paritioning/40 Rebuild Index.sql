USE [dotnetconsulting_DocumentAttributes]
GO
ALTER INDEX [CCI] ON [dbo].[DocumentIndex] REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = COLUMNSTORE)
GO
SELECT *, OBJECT_NAME(OBJECT_ID) FROM sys.[column_store_row_groups]
SELECT COUNT(*) FROM sys.[column_store_row_groups]
WHERE OBJECT_ID = OBJECT_ID('[dbo].[DocumentIndex]')
