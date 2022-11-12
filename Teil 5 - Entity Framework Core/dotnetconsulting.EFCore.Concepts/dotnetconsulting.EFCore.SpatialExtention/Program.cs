// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu
#pragma warning disable CS8321 // Local function is declared but never used

using dotnetconsulting.EFCore.SpatialExtention;
using dotnetconsulting.EFCore.SpatialExtention.Domains;
using NetTopologySuite.Geometries;

// createData();
QueryData();

Console.WriteLine("== Fertig == ");
Console.ReadKey();

static void CreateData()
{
    Random rnd = new();

    using Context context = new();
    // 10 Meßpunkte anlegen
    for (int i = 0; i < 10; i++)
    {
        Messpunkt messpunkt = new()
        {
            Zeitpunkt = DateTime.Now,
            Position = new Point(rnd.Next(1, 10), rnd.Next(1, 10)),
            Temperatur = rnd.NextDouble() * 100
        };

        context.Add(messpunkt);
    }
    context.SaveChanges();
}

static void QueryData()
{
    using Context context = new();

    Point mittelpunkt = new(5, 5);

    var query =
      from m in context.Messpunkte
      where m.Position.Distance(mittelpunkt) < 4
      orderby m.Position.Distance(mittelpunkt) descending
      select m;

    foreach (var m in query)
    {
        Console.WriteLine($"{m.Temperatur:N2} Grad um {m.Zeitpunkt:T} bei {m.Position}.");
    }
}