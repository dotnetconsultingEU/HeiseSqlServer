// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.Samples.EFContext;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.Data.Common;

namespace dotnetconsulting.Samples.Gui.DemoJobs;

public class DirectSql : IDemoJob
{
    private readonly ILogger<DirectSql> _logger;
    private readonly SamplesContext1 _efContext;

    public DirectSql(ILogger<DirectSql> logger, SamplesContext1 efContext)
    {
        _logger = logger;
        _efContext = efContext;
    }

    public string Title => "Direct SQL";

    public void Run()
    {
        Debugger.Break();

        #region Entitäten per Stored Procedure laden
        Console.Clear();
        var searchFor = "*dolo*";

        // Ausführen
        DbParameter searchTermPar = new SqlParameter("@SearchTerm", SqlDbType.VarChar, 50)
        {
            Value = searchFor
        };

        // Seit RC2 (nicht RC1!) erzeugt dies CS0121
        // Entfernen von Nuget package Microsoft.EntityFrameworkCore.Cosmos
        // würde helfen, führt aber zu anderen Problemen an anderen Stellen
        // Siehe *.csproj

        // Microsoft.EntityFrameworkCore.RelationalQueryableExtensions
        // Microsoft.EntityFrameworkCore.CosmosQueryableExtensions

        //List<Speaker> query1 = _efContext.Speakers
        //    .FromSqlRaw("EXEC dbo.usp_GetSpeaker @SearchTerm", searchTermPar)
        //    .ToList();

        // Workaround
        var query1 = RelationalQueryableExtensions
            .FromSqlRaw(_efContext.Speakers, "EXEC dbo.usp_GetSpeaker @SearchTerm", searchTermPar)
            .ToList();

        foreach (var speaker in query1)
        {
            Console.WriteLine(speaker);
        }


        // Ausführen (Raw)
        var query2 = _efContext.Speakers
            .FromSqlInterpolated($"EXEC dbo.usp_GetSpeaker '{searchFor}'")
            .ToList();

        foreach (var speaker in query2)
        {
            Console.WriteLine(speaker);
        }
        #endregion

        #region ExecuteSqlCommand
        Console.Clear();
        const string COMMANDUPDATE = @"UPDATE dnc.Speakers SET Infos = Infos + @Infos WHERE Id = @Id;";

        // Parameter definieren
        SqlParameter id = new("@Id", 3);
        SqlParameter infos = new("@Infos", "Neue Info");

        // Ausführen
        var rowsAffected = _efContext.Database.ExecuteSqlRaw(COMMANDUPDATE, id, infos);
        Console.WriteLine($"rowsAffected = {rowsAffected}");
        #endregion

        #region ADO.NET Core
        Console.Clear();
        const string COMMANDADONET = @"BACKUP DATABASE [dotnetconsulting.EFCoreSamples] TO DISK = 'c:\temp\EFCoreSamples.bak' WITH INIT;";

        // IDbCommand-Instanz vom Kontext geben lassen
        using IDbCommand cmd = _efContext.Database.GetDbConnection().CreateCommand();
        cmd.CommandType = CommandType.Text;
        cmd.CommandText = COMMANDADONET;

        // Verbindung zur Datenbank öffnen
        _efContext.Database.OpenConnection();

        // Ausführen
        cmd.ExecuteNonQuery();
        #endregion
    }
}