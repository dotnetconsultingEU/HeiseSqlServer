// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.TimeTracking.Interfaces;
using dotnetconsulting.TimeTracking.Interfaces.Dtos;
using dotnetconsulting.TimeTracking.Interfaces.Exceptions;

namespace dotnetconsulting.TimeTracking.AppLogic;

public class AppLogicV1 : IAppLogic
{
    private readonly IAppRepository _appRepository;

    public AppLogicV1(IAppRepository AppRepository)
    {
        _appRepository = AppRepository;
    }

    public async Task<IList<CustomerDto>> GetCustomersAsync(CancellationToken cancellationToken)
    {
        try
        {
            var result = (await _appRepository.GetCustomersAsync(cancellationToken).ConfigureAwait(false))
                .OrderBy(o => o.Displayname)
                .ToList();
            cancellationToken.ThrowIfCancellationRequested();
            return result;
        }
        catch (OperationCanceledException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new GeneralTimeTrackingException(ex.Message, ex);
        }
    }

    public async Task<IList<OrderDto>> GetOrdersAsync(CancellationToken cancellationToken)
    {
        try
        {
            var result = (await _appRepository.GetOrdersAsync(cancellationToken).ConfigureAwait(false))
                .OrderBy(o => o.OrderNr)
                .ToList();
            cancellationToken.ThrowIfCancellationRequested();
            return result;
        }
        catch (OperationCanceledException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new GeneralTimeTrackingException(ex.Message, ex);
        }
    }

    public async Task<IList<EntryDto>> GetTimeTrackingEntriesAsync(DateTime? Start, DateTime? End, int? OrderId, CancellationToken cancellationToken)
    {
        try
        {
            // Start und Ende ggf vertauschen
            if (Start.HasValue && End.HasValue && End < Start)
            {
                DateTime temp = Start.Value;
                Start = End;
                End = temp;
            }

            // Daten abrufen und zurückgeben
            var result = (await _appRepository.GetTimeTrackingEntriesAsync(Start, End, OrderId, cancellationToken).ConfigureAwait(false))
                .OrderBy(o => o.Day).ToList();
            cancellationToken.ThrowIfCancellationRequested();
            return result;
        }
        catch (OperationCanceledException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new GeneralTimeTrackingException(ex.Message, ex);
        }
    }

    public async Task<EntryDto> GetTimeTrackingEntryAsync(int Id, CancellationToken cancellationToken)
    {
        try
        {
            var result = await _appRepository.GetTimeTrackingEntryAsync(Id, cancellationToken).ConfigureAwait(false);
            cancellationToken.ThrowIfCancellationRequested();
            return result;
        }
        catch (OperationCanceledException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new GeneralTimeTrackingException(ex.Message, ex);
        }
    }

    public async Task<EntryDto> CreateNewTrackingEntryAsync(CancellationToken cancellationToken)
    {
        try
        {
            // Asynchron via Task, obwohl aktuell nicht notwendig
            var result = await Task.Factory.StartNew(() =>
           {
                    // Element erzeugen und mit Standardwerten belegen
                    EntryDto entry = new()
               {
                   Day = DateTime.Today
               };

                    // Rückgabe
                    return entry;
           }, cancellationToken).ConfigureAwait(false);
            cancellationToken.ThrowIfCancellationRequested();
            return result;
        }
        catch (OperationCanceledException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new GeneralTimeTrackingException(ex.Message, ex);
        }
    }

    public async Task StoreTimeTrackingAsync(EntryDto Entry, CancellationToken cancellationToken)
    {
        try
        {
            await _appRepository.StoreTrackingEntryAsync(Entry, cancellationToken).ConfigureAwait(false);
            cancellationToken.ThrowIfCancellationRequested();
        }
        catch (OperationCanceledException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new GeneralTimeTrackingException(ex.Message, ex);
        }
    }

    public async Task DeleteTimeTrackingAsync(int Id, CancellationToken cancellationToken)
    {
        try
        {
            await _appRepository.DeleteTrackingEntryAsync(Id, cancellationToken).ConfigureAwait(false);
            cancellationToken.ThrowIfCancellationRequested();
        }
        catch (OperationCanceledException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new GeneralTimeTrackingException(ex.Message, ex);
        }
    }

    public async Task<bool> AnyEntryOnDateAsync(int Id, DateTime Date, CancellationToken cancellationToken)
    {
        try
        {
            var result = await _appRepository.AnyEntryOnDate(Id, Date, cancellationToken).ConfigureAwait(false);
            cancellationToken.ThrowIfCancellationRequested();
            return result;
        }
        catch (OperationCanceledException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new GeneralTimeTrackingException(ex.Message, ex);
        }
    }
}