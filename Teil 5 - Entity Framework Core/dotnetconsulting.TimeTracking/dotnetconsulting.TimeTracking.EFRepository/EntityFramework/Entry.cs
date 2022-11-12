// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu
#nullable disable

namespace dotnetconsulting.TimeTracking.EFRepository.EntityFramework;

internal class Entry
{
    public int Id { get; set; }
    public Order Order { get; set; }
    public int OrderId { get; set; }
    public DateTime Day { get; set; }
    public TimeSpan Start { get; set; }
    public TimeSpan End { get; set; }
    public TimeSpan? Break { get; set; }
    public string Place { get; set; }
    public string Description { get; set; }

    public DateTime CreatedOrModified { get; set; }
}