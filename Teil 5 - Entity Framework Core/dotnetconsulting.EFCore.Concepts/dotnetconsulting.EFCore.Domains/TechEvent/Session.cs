// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

namespace dotnetconsulting.EFCore.Domains;

public class Session
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Presenter { get; set; }
    public int Duration { get; set; }
    public DifficultyLevel Difficulty { get; set; }
    public string Abstract { get; set; }
    // public List<string> Voters { get; set; } = new List<string>();
    public int? EventId { get; set; }
    public List<SpeakerSession> SpeakerSessions { get; set; }
    public int SpeakerId { get; set; }
    public TechEvent TechEvent { get; set; }
    public int TechEventId { get; set; }
}

public enum DifficultyLevel
{
    Level1,
    Level2,
    Level3,
    Level4
}