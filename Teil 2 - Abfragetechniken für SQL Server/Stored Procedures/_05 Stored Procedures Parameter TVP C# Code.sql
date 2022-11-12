
CREATE TYPE tImport AS TABLE
(
    ID INT NULL,
    CatalogID INT NOT NULL,
    LanguageID CHAR(2) NULL,
    ProductID NVARCHAR(50) NOT NULL,
    Brand NVARCHAR(100) NOT NULL,
    ProductFamily NVARCHAR(100) NOT NULL,
    EAN VARCHAR(20) NULL,
    Status INT NULL,
    StatusDate DATETIME NULL
);

// DataTable inkl. seiner Spalten erstellen
dt = new DataTable("Import");

dt.Columns.Add("ID", typeof(int));
dt.Columns.Add("CatalogID", typeof(int));
dt.Columns.Add("LanguageID", typeof(string));
dt.Columns.Add("ProductID", typeof(string));
dt.Columns.Add("Brand", typeof(string));
dt.Columns.Add("ProductFamily", typeof(string));
dt.Columns.Add("EAN", typeof(string));
dt.Columns.Add("Status", typeof(string));
dt.Columns.Add("StatusDate", typeof(DateTime));


CREATE PROC [dbo].[usp_InsertProductTVPwithID]
    @ImportTable tImport READONLY
AS
BEGIN	
    INSERT INTO 
    [dbo].[Products]
       ([CatalogID], [LanguageID], [ProductID], [Brand],
        [ProductFamily], [EAN], [Status], [StatusDate])
    OUTPUT inserted.IDENTITYCOL
    SELECT [CatalogID], [LanguageID], [ProductID], [Brand],
           [ProductFamily], [EAN], [Status], [StatusDate]
    FROM @ImportTable;
END;

void ImportDataTVPWithID(string conString, DataTable dt)
{
    const string sql = "usp_InsertProductTVPwithID";

    using (SqlConnection con = new SqlConnection(conString))
    {
        con.Open();
        using (SqlCommand cmd = con.CreateCommand())
        {
            // Abfrage festlegen
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = sql;

            // Parameter hinzufügen
            cmd.Parameters.AddWithValue("ImportTable", dt);

            // Ausführen und Identitätswerte zuordnen
            int RowIndex = 0;
            using (SqlDataReader dr = cmd.ExecuteReader())
                while (dr.Read())
                    // Identitätswert übernehmen
                    dt.Rows[RowIndex++]["ID"] = dr.GetInt32(0);

            // ggf. Änderungen annehmen
            dt.AcceptChanges();
        }
    }
}