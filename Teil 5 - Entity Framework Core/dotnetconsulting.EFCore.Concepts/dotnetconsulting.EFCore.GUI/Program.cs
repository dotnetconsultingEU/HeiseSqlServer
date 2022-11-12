// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.EFCore.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;


// Konfiguration vorbereiten
IConfigurationBuilder configBuilder = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json");

IConfigurationRoot config = configBuilder.Build();

using (TechEventContext context = new TechEventContext())
{
    int speakerId = 7;

    var q = context.SpeakerSession
        .Include(i => i.Speaker)
        .Include(i => i.Session)
        .Where(w => w.SpeakerId == speakerId)
        .Select(s => new { SpeakerName = s.Speaker.Name, SessionTitle = s.Session.Name })
        .ToList();

    foreach (var item in q)
    {
        Console.WriteLine(item);
    }
}

Console.WriteLine("Fertig");
Console.ReadKey();