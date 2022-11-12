// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

#pragma warning disable IDE0052 // Remove unread private members

using dotnetconsulting.Samples.EFContext;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Transactions;

namespace dotnetconsulting.Samples.Gui.DemoJobs;

public class Transactions : IDemoJob
{
    private readonly ILogger<Transactions> _logger;
    private readonly SamplesContext1 _efContext1;
    private readonly SamplesContext3 _efContext3;
    private readonly IConfigurationRoot _configuration;

    public Transactions(ILogger<Transactions> logger,
                        SamplesContext1 efContext1,
                        SamplesContext3 efContext3,
                        IConfigurationRoot configuration)
    {
        _logger = logger;
        _efContext1 = efContext1;
        _efContext3 = efContext3;
        _configuration = configuration;
    }

    public string Title => "Transactions";

    public void Run()
    {
        Debugger.Break();

        using (DbConnection con = new SqlConnection(_configuration["ConnectionStrings:EFConString"]))
        {
            con.Open();

            using TransactionScope scope = new(TransactionScopeOption.Required);
            // Änderungen an Kontext1
            // _efContext1.Speakers.Remove(...);

            // Änderungen an Kontext3
            // _efContext3.Speakers.Remove(...);

            using (var cmd = con.CreateCommand())
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "...";
                cmd.ExecuteNonQuery();
            }

            _efContext1.SaveChanges();
            _efContext3.SaveChanges();

            // Gesamte Transaktion freigeben
            scope.Complete();
        }

        // Externe Transaktion "enlisten"
        using (CommittableTransaction scope = new())
        {
            using (DbConnection con = new SqlConnection(_configuration["ConnectionStrings:EFConString"]))
            {
                con.Open();

                _efContext1.Database.OpenConnection();
                _efContext1.Database.EnlistTransaction(scope);

                using var cmd = con.CreateCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "DELETE FROM ";
                cmd.ExecuteNonQuery();

                // _efContext1.Speakers.Remove(...);
                _efContext1.SaveChanges();
            }

            scope.Commit();
        }
    }
}