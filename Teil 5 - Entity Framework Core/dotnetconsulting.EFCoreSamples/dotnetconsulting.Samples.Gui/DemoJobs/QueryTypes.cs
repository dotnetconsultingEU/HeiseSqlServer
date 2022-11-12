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
using Microsoft.Extensions.Logging;
using System.Diagnostics;

namespace dotnetconsulting.Samples.Gui.DemoJobs;

public class QueryTypes : IDemoJob
{
    private readonly ILogger<QueryTypes> _logger;
    private readonly SamplesContext1 _efContext;

    public QueryTypes(ILogger<QueryTypes> logger, SamplesContext1 efContext)
    {
        _logger = logger;
        _efContext = efContext;
    }

    public string Title => "Query Types";

    public void Run()
    {
        Debugger.Break();

        // Abfrage durchführen. Der Query Type sorgt für einen 
        // Zugriff auf den View
        var query = _efContext.SpeakerStatistics.OrderBy(o => o.NumerOfSessions);

        // Ausführung #1
        foreach (var item in query)
            Console.WriteLine($"{item.Name}, Count:{item.NumerOfSessions:N0}");

        // Ausführung #2
        foreach (var item in query)
            Console.WriteLine($"{item.Name}, Count:{item.NumerOfSessions:N0}");
    }
}