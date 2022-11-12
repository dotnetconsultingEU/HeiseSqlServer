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
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Diagnostics;

#pragma warning disable IDE0051 // Remove unused private members

namespace dotnetconsulting.Samples.Gui.DemoJobs;

public class DeleteEntities : IDemoJob
{
    private readonly ILogger<DeleteEntities> _logger;
    private readonly SamplesContext1 _efContext;

    public DeleteEntities(ILogger<DeleteEntities> logger, SamplesContext1 efContext)
    {
        _logger = logger;
        _efContext = efContext;
    }

    public string Title => "Delete Entities";

    public void Run()
    {
        Debugger.Break();

        #region Via Context abfragen
        Console.Clear();
        var speaker1 = _efContext.Find<Speaker>(99); // Gültige ID?

        if (speaker1 != null)
        {
            // Löschen
            _efContext.Remove(speaker1);
            // oder 
            _efContext.Speakers.Remove(speaker1);
        }
        // Speichern
        _efContext.SaveChanges();
        #endregion

        #region An Context anhängen (Entry)
        Console.Clear();

        if (_efContext.Speakers.Any(a => a.Id == 34))
        {
            Speaker speaker2 = new() { Id = 34 };

            _efContext.Entry(speaker2).State = EntityState.Deleted;
            // Speichern
            _efContext.SaveChanges();
        }
        #endregion
    }

    private static bool CheckName(string Name)
    {
        return string.IsNullOrWhiteSpace(Name);
    }
}