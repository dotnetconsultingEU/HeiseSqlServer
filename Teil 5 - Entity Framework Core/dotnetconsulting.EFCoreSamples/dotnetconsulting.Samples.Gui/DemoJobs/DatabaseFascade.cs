// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

#pragma warning disable IDE0052 // Remove unread private members
#pragma warning disable IDE0059 // Unnecessary assignment of a value

using dotnetconsulting.Samples.EFContext;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Diagnostics;

namespace dotnetconsulting.Samples.Gui.DemoJobs;

public class DatabaseFacade : IDemoJob
    {
        private readonly ILogger<DatabaseFacade> _logger;
        private readonly SamplesContext1 _efContext;

        public DatabaseFacade(ILogger<DatabaseFacade> logger, SamplesContext1 efContext)
        {
            _logger = logger;
            _efContext = efContext;
        }

        public string Title => "Query Entities";

        public void Run()
        {
            Debugger.Break();

            // Welcher Provider
            var providerName = _efContext.Database.ProviderName;
            Console.WriteLine(providerName);
                        
            // Stehen Migrations aus?
            var openMigrations = _efContext.Database.GetPendingMigrations();

            if (openMigrations.Any())
                // Anwenden
                _efContext.Database.Migrate();

            // Sicherstellen, das DB erzeugt ist
            Debugger.Break();
            _efContext.Database.EnsureCreated();

            // Oder genau das Gegenteil
            Debugger.Break();
            _efContext.Database.EnsureDeleted();

            // Verbindung abgreifen
            var connetion = _efContext.Database.GetDbConnection();

            // Transaction
            var transaction = _efContext.Database.CurrentTransaction;
        }
    }