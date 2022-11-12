// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

#pragma warning disable IDE0051 // Remove unread private members

using Newtonsoft.Json;

namespace dotnetconsulting.Samples.Domains;

public class Speaker
{
#pragma warning disable IDE1006 // Naming Styles
    public int _Id { get; }
#pragma warning restore IDE1006 // Naming Styles

    private Speaker(int id) : this()
    {
        Id = id;
    }

    public int Id { get; set; }

    public string Name { get; set; }

    public string Homepage { get; set; }

    public string Twitter { get; set; }

    public string Infos { get; set; }

    public string LinkedIn { get; set; }

    public virtual ICollection<SpeakerSession> SpeakerSessions { get; set; } = new List<SpeakerSession>();

    public DateTime Created { get; set; }

    public DateTime? Updated { get; set; }

    public bool IsDeleted { get; set; }

    public Speaker()
    {
        SpeakerSessions = new HashSet<SpeakerSession>();
    }

    public override string ToString()
    {
        JsonSerializerSettings settings = new()
        {
            ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
            Formatting = Formatting.Indented
        };

        return JsonConvert.SerializeObject(this, settings);
    }
}