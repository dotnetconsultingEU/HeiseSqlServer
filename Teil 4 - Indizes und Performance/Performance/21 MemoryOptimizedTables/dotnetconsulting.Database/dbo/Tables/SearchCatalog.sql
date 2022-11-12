CREATE TABLE [dbo].[SearchCatalog] (
    [ID]          INT      NOT NULL,
    [Start]       DATETIME NOT NULL,
    [End]         DATETIME NOT NULL,
    [Criterium01] INT      NOT NULL,
    [Criterium02] INT      NOT NULL,
    [Criterium03] INT      NOT NULL,
    [Criterium04] INT      NOT NULL,
    [Criterium05] INT      NOT NULL,
    [Criterium06] INT      NOT NULL,
    [Criterium07] INT      NOT NULL,
    [Criterium08] INT      NOT NULL,
    [Criterium09] INT      NOT NULL,
    [Criterium10] INT      NOT NULL,
    [Criterium11] INT      NULL,
    [Criterium12] INT      NULL,
    [Criterium13] INT      NULL,
    [Criterium14] INT      NULL,
    [Criterium15] INT      NULL,
    [Criterium16] INT      NULL,
    [Criterium17] INT      NULL,
    [Criterium18] INT      NULL,
    [Criterium19] INT      NULL,
    [Criterium20] INT      NULL,
    [ACTIVE]      BIT      DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_sample_memoryoptimizedtable] PRIMARY KEY NONCLUSTERED ([ID] ASC)
)
WITH (DURABILITY = SCHEMA_ONLY, MEMORY_OPTIMIZED = ON);

