// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.TimeTracking.Interfaces.Dtos;

namespace dotnetconsulting.TimeTracking.Interfaces;

public interface IAppLogic
{
    Task<IList<EntryDto>> GetTimeTrackingEntriesAsync(DateTime? Start, DateTime? End, int? OrderId, CancellationToken cancellationToken);
    Task<EntryDto> GetTimeTrackingEntryAsync(int Id, CancellationToken cancellationToken);
    Task StoreTimeTrackingAsync(EntryDto Entry, CancellationToken cancellationToken);
    Task<EntryDto> CreateNewTrackingEntryAsync(CancellationToken cancellationToken);
    Task DeleteTimeTrackingAsync(int Id, CancellationToken cancellationToken);
    Task<bool> AnyEntryOnDateAsync(int Id, DateTime Date, CancellationToken cancellationToken);
    Task<IList<CustomerDto>> GetCustomersAsync(CancellationToken cancellationToken);
    Task<IList<OrderDto>> GetOrdersAsync(CancellationToken cancellationToken);
}