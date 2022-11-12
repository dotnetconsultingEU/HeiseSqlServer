// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

namespace dotnetconsulting.EFCore.Domains;

public class TechEvent
{
    public int Id { get; set; }
    public string Name { get; set; }
    public DateTime Start { get; set; }
    public decimal Price { get; set; }
    public string ImageUrl { get; set; }
    public string LocationCity { get; set; }
    public string LocationCountry { get; set; }
    public string OnlineUrl { get; set; }
    public List<Session> Sessions { get; set; } = new List<Session>();
}