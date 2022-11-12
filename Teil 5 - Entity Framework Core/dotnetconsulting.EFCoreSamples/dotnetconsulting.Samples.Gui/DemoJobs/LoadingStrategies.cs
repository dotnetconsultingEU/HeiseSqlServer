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
using Newtonsoft.Json;
using System.Diagnostics;

namespace dotnetconsulting.Samples.Gui.DemoJobs;

public class LoadingStrategies : IDemoJob
{
    private readonly ILogger<LoadingStrategies> _logger;
    private readonly SamplesContext1 _efContext;

    public LoadingStrategies(ILogger<LoadingStrategies> logger, SamplesContext1 efContext)
    {
        _logger = logger;
        _efContext = efContext;
    }

    public string Title => "Loading Strategies";

    public void Run()
    {
        Debugger.Break();

        const int techEventId = 10;

        // Welche Strategie darf es sein?
        var strategy = DemoLoadingStrategy.Preloading;
        TechEvent techEvent = null;

        Console.Clear();

        switch (strategy)
        {
            case DemoLoadingStrategy.LazyLoadingAutomatic:
                #region LazyLoadingAutomatic

                // Direkte Unterstützung, hier kein weiterer Code
                techEvent = _efContext.TechEvents.SingleOrDefault(t => t.Id == techEventId);

                break;
            #endregion
            case DemoLoadingStrategy.LazyLoadingExplicit:
                #region LazyLoadingExplicit

                techEvent = _efContext.TechEvents.Find(techEventId);

                _efContext.Entry(techEvent).Collection(e => e.Sessions).Load();
                _efContext.Entry(techEvent).Reference(e => e.VenueSetup).Load();

                break;
            #endregion
            case DemoLoadingStrategy.Preloading:
                #region Preloading

                // Alle Sprecher laden
                _ = _efContext.TechEvents.ToList();
                _ = _efContext.Speakers.ToList();
                _ = _efContext.SpeakerSessions.ToList();

                // Zugriff aus dem Speicher
                techEvent = _efContext.TechEvents.Find(techEventId);

                break;
            #endregion
            case DemoLoadingStrategy.EagerLoading:
                #region EagerLoading

                techEvent = _efContext.TechEvents
                    .Include(i => i.Sessions).ThenInclude(i => i.SpeakerSessions)
                    .Include(i => i.VenueSetup)
                    .SingleOrDefault(t => t.Id == techEventId);

                break;
            #endregion
            default:
                break;
        }

        JsonSerializerSettings settings = new()
        {
            ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
            Formatting = Formatting.Indented
        };
        var json = JsonConvert.SerializeObject(techEvent, settings);
        // Console.WriteLine(json);
    }

    public enum DemoLoadingStrategy
    {
        LazyLoadingAutomatic,
        LazyLoadingExplicit,
        Preloading,
        EagerLoading
    }
}