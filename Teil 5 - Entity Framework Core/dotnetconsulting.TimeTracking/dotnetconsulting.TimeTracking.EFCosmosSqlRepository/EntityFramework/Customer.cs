// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu
#nullable disable

namespace dotnetconsulting.TimeTracking.EFCosmosSqlRepository.EntityFramework;
public class Customer
{
    public int Id { get; set; }
    public bool IsActive { get; set; }
    public string Displayname { get; set; }
    public string Comment { get; set; }
    public ICollection<Order> Orders { get; set; } = new List<Order>();
}