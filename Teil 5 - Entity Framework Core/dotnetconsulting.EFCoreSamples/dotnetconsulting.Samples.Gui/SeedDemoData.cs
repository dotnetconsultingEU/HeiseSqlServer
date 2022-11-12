// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.Samples.Domains;
using dotnetconsulting.Samples.EFContext;

namespace dotnetconsulting.Samples.Gui
{
    public static class SamplesContextExtentions
    {
        public static void SeedDemoData(this SamplesContext1 context)
        {
            // Daten hinzufügen, wenn es noch keine gibt
            if (!context.Speakers.Any())
            {
                for (var i = 1; i <= 10; i++)
                {
                    Speaker speaker = new()
                    {
                        Name = $"Speaker {i}",
                        Infos = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam!",
                        Homepage = "http://www.dotnetconsulting.eu"
                    };

                    context.Speakers.Add(speaker);
                }
            }

            if (!context.TechEvents.Any())
            {
                for (var i = 1; i <= 10; i++)
                {
                    TechEvent techEvent = new()
                    {
                        Name = $"Event {i}",
                        Begin = DateTime.Now,
                        End = DateTime.Now.AddDays(3),

                        ImageUrl = "http://www.dotnetconsulting.eu"
                    };

                    context.TechEvents.Add(techEvent);
                }
            }

            context.SaveChanges();
        }
    }
}