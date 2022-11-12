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

namespace dotnetconsulting.Samples.Gui.DemoJobs;

public class ModifyEntities : IDemoJob
{
    private readonly ILogger<ModifyEntities> _logger;
    private readonly SamplesContext1 _efContext;

    public ModifyEntities(ILogger<ModifyEntities> logger, SamplesContext1 efContext)
    {
        _logger = logger;
        _efContext = efContext;
    }

    public string Title => "Modify Entities";

    public void Run()
    {
        Debugger.Break();

        #region  Via Context abfragen
        Console.Clear();
        var speaker1 = _efContext.Find<Speaker>(7);
        // Änderung
        speaker1.Name = "Name<Peng>!";
        // Speichern
        _efContext.SaveChanges();
        #endregion

        #region An Context anhängen (Attach)
        Console.Clear();
        Speaker speaker2 = new() { Id = 0, Name = "xxxx" };
        _efContext.Attach(speaker2);
        // Speichern
        _efContext.SaveChanges();
        #endregion

        #region An Context anhängen (Entry)
        Console.Clear();
        Speaker speaker3 = new() { Id = 11, Name = "Harry Hirsch", Infos = "..." };
        _efContext.Entry(speaker3).State = EntityState.Modified;
        // Speichern
        _efContext.SaveChanges();
        #endregion
    }
}