// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

#pragma warning disable IDE0052 // Remove unread private members

using dotnetconsulting.Samples.Domains;
using dotnetconsulting.Samples.EFContext;
using Microsoft.Extensions.Logging;
using System.Diagnostics;
using Microsoft.EntityFrameworkCore;

namespace dotnetconsulting.Samples.Gui.DemoJobs;

public class GlobalQueryFilter : IDemoJob
{
    private readonly ILogger<GlobalQueryFilter> _logger;
    private readonly SamplesContext1 _efContext;

    public GlobalQueryFilter(ILogger<GlobalQueryFilter> logger, SamplesContext1 efContext)
    {
        _logger = logger;
        _efContext = efContext;
    }

    public string Title => "Global Query Filter";

    public void Run()
    {
        Debugger.Break();

        var sessionId = 1;

        // Abfragen mit (globalem) Filter
        Console.Clear();
        var session1 = _efContext.Sessions.Find(sessionId);

        var query1 = from q in _efContext.Sessions
                     where q.Difficulty == DifficultyLevel.Level2
                     select q;
        Console.WriteLine($"query1.Count() = {query1.Count()}");

        // Abfragen ohne (globalem) Filter
        Console.Clear();

        var session2 = _efContext.Sessions
            .IgnoreQueryFilters()
            .SingleOrDefault(w => w.Id == sessionId);

        var query2 = from q in _efContext.Sessions.IgnoreQueryFilters()
                     where q.Difficulty == DifficultyLevel.Level2
                     select q;
        Console.WriteLine($"query2.Count() = {query2.Count()}");
    }
}