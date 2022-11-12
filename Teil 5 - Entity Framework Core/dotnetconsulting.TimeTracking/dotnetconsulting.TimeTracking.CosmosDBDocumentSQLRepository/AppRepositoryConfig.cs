// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

namespace dotnetconsulting.TimeTracking.CosmosDBDocumentSQLRepository;

public class AppRepositoryCosmosSqlConfig
{
    internal readonly string Endpoint;
    internal readonly string Key;

    internal readonly string DatabaseId;
    internal readonly string CollectionId;

    public AppRepositoryCosmosSqlConfig(string Endpoint, string Key, string DatabaseId, string CollectionId)
    {
        // Werte speichern
        this.Endpoint = Endpoint;
        this.Key = Key;
        this.DatabaseId = DatabaseId;
        this.CollectionId = CollectionId;
    }
}