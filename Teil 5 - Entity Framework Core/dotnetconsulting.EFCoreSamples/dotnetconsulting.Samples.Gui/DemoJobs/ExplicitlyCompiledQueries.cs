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
using dotnetconsulting.Samples.Domains;

namespace dotnetconsulting.Samples.Gui.DemoJobs;

public class ExplicitlyCompiledQueries : IDemoJob
{
    private readonly ILogger<ExplicitlyCompiledQueries> _logger;
    private readonly SamplesContext1 _efContext;

    public ExplicitlyCompiledQueries(ILogger<ExplicitlyCompiledQueries> logger, SamplesContext1 efContext)
    {
        _logger = logger;
        _efContext = efContext;
    }

    public string Title => "Explicitly Compiled Queries";

    // Explicitly complied Queries
    private static readonly Func<SamplesContext1, int, Session> sessionById =
        EF.CompileQuery((SamplesContext1 ctx, int id) =>
            ctx.Sessions.SingleOrDefault(s => s.Id == id));

    public void Run()
    {
        Debugger.Break();

        // Aufruf
#pragma warning disable IDE0059 // Unnecessary assignment of a value
        var session1 = sessionById(_efContext, 10);
#pragma warning restore IDE0059 // Unnecessary assignment of a value
    }
}