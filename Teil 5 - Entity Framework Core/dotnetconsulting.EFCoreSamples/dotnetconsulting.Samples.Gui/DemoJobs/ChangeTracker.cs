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
using Microsoft.Extensions.Logging;
using System.Diagnostics;

namespace dotnetconsulting.Samples.Gui.DemoJobs;

class ChangeTracker : IDemoJob
{
    private readonly ILogger<ChangeTracker> _logger;
    private readonly SamplesContext1 _efContext;

    public ChangeTracker(ILogger<ChangeTracker> logger, SamplesContext1 efContext)
    {
        _logger = logger;
        _efContext = efContext;
    }

    public string Title => "Change Tracker";

    public void Run()
    {
        Debugger.Break();

        // Change Tracker - AutoDetectChangesEnabled
        _efContext.ChangeTracker.AutoDetectChangesEnabled = false;

        // Change Tracker - Alles tracken außer...
        _efContext.ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.TrackAll;

        var queryNoTrack = from q in _efContext.Speakers.AsNoTracking()
                           where q.Name.StartsWith("Speaker")
                           select q;

        // Change Tracker - Nichts tracken außer...
        _efContext.ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;

        var queryTrack = from q in _efContext.Speakers.AsTracking()
                         where q.Name.StartsWith("Speaker")
                         select q;

        #region Alle bekannten Änderungen durchlaufen
        Console.Clear();

        // Änderung herbeiführen
        var speaker = queryTrack.First();
        // speaker.Name = "Harry";
        speaker.Updated = DateTime.Now;

        // AutoDetectChangesEnabled berücksichtigen, sonst werden
        // die Eigenschaften nicht richtig (eigentlich gar nicht) ausgewiesen

        _efContext.ChangeTracker.AutoDetectChangesEnabled = false;
        if (!_efContext.ChangeTracker.AutoDetectChangesEnabled)
            _efContext.ChangeTracker.DetectChanges();

        foreach (var entry in _efContext.ChangeTracker.Entries())
        {
            Console.WriteLine("=== Entität ===");
            Console.WriteLine(entry.Entity);

            Console.WriteLine("=== Eigenschaften ===");
            // Alle Eigenschafen durchlaufen
            foreach (var property in entry.Properties.Where(w => w.IsModified))
            {
                Console.WriteLine($"{property.Metadata.Name}, ClrType={property.Metadata.ClrType.Name}, Orginal='{property.OriginalValue}', Current='{property.CurrentValue}', IsModified={property.IsModified}");
                // Einige Eigenschaften können verändert werden
                // property.IsModified = false;
                // property.CurrentValue = null;
                // property.OriginalValue = null;
            }
        }
        #endregion

        // Ab 5.0 ist auch ein Clear (Reset) möglich
        _efContext.ChangeTracker.Clear();
    }
}