// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;

// ConnectionString & Umfang der DemoDaten aus Configuration lesen
IConfigurationRoot config = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json")
    .Build();
string conString = config.GetConnectionString("Demo");
int numberOfRows = config.GetValue("NumberOfRows", 100000);

// Zeitmessung via Stopwatch
Stopwatch sw = new();
var demoData = createDemoTicketsDataTable();

// Insert (Prepare)
sw.Reset();
using (SqlConnection con = new SqlConnection(conString))
{
    con.Open();
    using (SqlCommand cmd = con.CreateCommand())
    {
        cmd.CommandType = CommandType.Text;
        cmd.CommandText = "INSERT dbo.Tickets (Status, TraceID) VALUES (@Status, @TraceID);";

        var parStatus = new SqlParameter("Status", SqlDbType.VarChar, 50);
        var parTraceId = new SqlParameter("TraceID", SqlDbType.Int, 0);

        cmd.Parameters.Add(parStatus);
        cmd.Parameters.Add(parTraceId);

        cmd.Prepare();

        sw.Start();
        foreach (DataRow row in demoData.Rows)
        {
            parStatus.Value = row["Status"];
            parTraceId.Value = row["TraceId"];

            cmd.ExecuteNonQuery();
        }
        sw.Stop();
        Console.WriteLine($"Insert: {numberOfRows:N0} Zeile in {sw.ElapsedMilliseconds:N0} ms");
    }
}

// TVP
sw.Reset();
using (SqlConnection con = new SqlConnection(conString))
{
    con.Open();
    using (SqlCommand cmd = con.CreateCommand())
    {
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "dbo.usp_StoredProcedure_TVP_CreateTickets";

        cmd.Parameters.AddWithValue("tickets", demoData);

        sw.Start();
        cmd.ExecuteNonQuery();
        sw.Stop();
        Console.WriteLine($"TVP: {numberOfRows:N0} Zeile in {sw.ElapsedMilliseconds:N0} ms");
    }
}

// BulkInsert
sw.Reset();
using (SqlConnection con = new SqlConnection(conString))
{
    con.Open();

    SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con);

    sqlBulkCopy.DestinationTableName = "dbo.Tickets";

    // Achtung! Case-sensitive
    sqlBulkCopy.ColumnMappings.Add("Status", "Status");
    sqlBulkCopy.ColumnMappings.Add("TraceId", "TraceID");

    sqlBulkCopy.EnableStreaming = true;

    sw.Start();
    sqlBulkCopy.WriteToServer(demoData);
    sw.Stop();
    Console.WriteLine($"Bulk: {numberOfRows:N0} Zeile in {sw.ElapsedMilliseconds:N0} ms");
}

Console.WriteLine("== Fertig ==");

DataTable createDemoTicketsDataTable()
{
    DataTable data = new();
    data.Columns.Add("Status", typeof(string));
    data.Columns.Add("TraceID", typeof(int));

    for (int i = 0; i < numberOfRows; i++)
        data.Rows.Add($"Status: {i}", i);

    return data;
}