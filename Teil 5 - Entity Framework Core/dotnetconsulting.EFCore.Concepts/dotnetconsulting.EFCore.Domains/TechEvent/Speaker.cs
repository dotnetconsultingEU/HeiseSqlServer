// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

namespace dotnetconsulting.EFCore.Domains;

public class Speaker
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string WebSite { get; set; }
    public string Description { get; set; }
    public List<SpeakerSession> SpeakerSessions { get; set; } = new List<SpeakerSession>();
    public SecredIdentity SecredIdentity { get; set; }
}