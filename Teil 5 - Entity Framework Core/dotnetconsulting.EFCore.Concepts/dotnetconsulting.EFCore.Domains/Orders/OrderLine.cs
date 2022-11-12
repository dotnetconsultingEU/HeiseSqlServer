// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

namespace dotnetconsulting.EFCore.Domains;

public class OrderLine
{
    // EFCore 2.2 Preview 3 benötigt einen Entity Key!?
    public string Id { get; set; }

    public decimal Amount { get; set; }

    public string Product { get; set; }

    public int ProductNr { get; set; }

    public OrderLineStatus Status { get; set; }
}