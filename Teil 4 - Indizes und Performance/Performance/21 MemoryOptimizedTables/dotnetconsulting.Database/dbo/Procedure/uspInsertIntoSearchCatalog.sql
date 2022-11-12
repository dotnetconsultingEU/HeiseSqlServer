CREATE PROCEDURE dbo.uspInsertIntoSearchCatalog
(
    @Start DATETIME,
    @End DATETIME,
    @Criterium01 INT,
    @Criterium02 INT,
    @Criterium03 INT,
    @Criterium04 INT,
    @Criterium05 INT,
    @Criterium06 INT,
    @Criterium07 INT,
    @Criterium08 INT,
    @Criterium09 INT,
    @Criterium10 INT,
    @Criterium11 INT,
    @Criterium12 INT,
    @Criterium13 INT,
    @Criterium14 INT,
    @Criterium15 INT,
    @Criterium16 INT,
    @Criterium17 INT,
    @Criterium18 INT,
    @Criterium19 INT,
    @Criterium20 INT,
    @Active BIT
)
WITH NATIVE_COMPILATION, SCHEMABINDING
AS
BEGIN ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'English')

    INSERT INTO [dbo].[SearchCatalog]
    (
        [Start],
        [End],
        [Criterium01],
        [Criterium02],
        [Criterium03],
        [Criterium04],
        [Criterium05],
        [Criterium06],
        [Criterium07],
        [Criterium08],
        [Criterium09],
        [Criterium10],
        [Criterium11],
        [Criterium12],
        [Criterium13],
        [Criterium14],
        [Criterium15],
        [Criterium16],
        [Criterium17],
        [Criterium18],
        [Criterium19],
        [Criterium20],
        [ACTIVE]
    )
    VALUES
    (@Start, @End, @Criterium01, @Criterium02, @Criterium03, @Criterium04, @Criterium05, @Criterium06, @Criterium07,
     @Criterium08, @Criterium09, @Criterium10, @Criterium11, @Criterium12, @Criterium13, @Criterium14, @Criterium15,
     @Criterium16, @Criterium17, @Criterium18, @Criterium19, @Criterium20, @Active);
END;