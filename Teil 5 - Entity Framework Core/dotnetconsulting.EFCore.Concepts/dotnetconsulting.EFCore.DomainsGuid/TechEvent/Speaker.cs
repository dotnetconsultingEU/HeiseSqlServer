// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

namespace dotnetconsulting.EFCore.DomainsGuid;

public class SpeakerGuid
{
    public SpeakerGuid()
    {
        MainExperience = new Experience();
        Experiences = new List<Experience>();
    }

    public Guid Id { get; set; }
    public string Name { get; set; }
    public string WebSite { get; set; }
    public string Description { get; set; }
    public List<SpeakerSessionGuid> SpeakerSessions { get; set; } = new List<SpeakerSessionGuid>();
    public SecredIdentityGuid SecredIdentity { get; set; }

    public Experience MainExperience { get; set; }

    public IList<Experience> Experiences { get; set; }
}