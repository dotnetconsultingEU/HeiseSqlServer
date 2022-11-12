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
using System.Diagnostics;

#pragma warning disable CS8618 // Non-nullable field must contain a non-null value when exiting constructor. Consider declaring as nullable.

namespace dotnetconsulting.Samples.Gui.DemoJobs;

public class TemporalTable : IDemoJob
{
    private readonly ILogger<TemporalTable> _logger;
    private readonly SamplesContext1 _efContext1;

    public string Title => "Temporal tables";

    public void Run()
    {
        Debugger.Break();

        // ALL - Alle Daten aus der Tabelle und der historischen Tabelle.
        var r1 = _efContext1.Sessions.TemporalAll().Where(w => w.TechEventId == 1);

        // AS OF - Daten zu einem bestimmten Zeitpunkt.
        var r2 = _efContext1.Sessions.TemporalAsOf(DateTime.UtcNow).Where(w => w.TechEventId == 1);

        // FROM TO - Daten zwischen den beiden Zeitpunkten unter Auschluss der oberen Grenze.
        var r3 = _efContext1.Sessions.TemporalFromTo(DateTime.UtcNow, DateTime.UtcNow.AddDays(1)).Where(w => w.TechEventId == 1);

        // BETWEEN - Daten aus der Tabelle plus der historischen Tabelle inkl. Einschluss der oberen Grenze.
        var r4 = _efContext1.Sessions.TemporalBetween(DateTime.UtcNow, DateTime.UtcNow.AddDays(1)).Where(w => w.TechEventId == 1);

        // CONTAINED - Nur Daten aus den der historischen Tabelle aus dem Zeitraum.
        var r5 = _efContext1.Sessions.TemporalContainedIn(DateTime.UtcNow, DateTime.UtcNow.AddDays(1)).Where(w => w.TechEventId == 1);
    }
}