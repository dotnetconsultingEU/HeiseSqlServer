// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu
#nullable disable

namespace dotnetconsulting.TimeTracking.CosmosDBDocumentSQLRepository.ComosDB;

internal class Order
{
    public int Id { get; set; }
    public Customer Customer { get; set; }
    public int CustomerId { get; set; }
    public string OrderNr { get; set; }
    public string Description { get; set; }
    public DateTime Created { get; set; }
    public ICollection<Entry> Entires { get; set; }
    public string Discriminator { get; } = nameof(Order);
}