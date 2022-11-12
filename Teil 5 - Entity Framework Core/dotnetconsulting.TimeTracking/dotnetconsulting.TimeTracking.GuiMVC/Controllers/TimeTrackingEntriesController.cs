// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using AutoMapper;
using dotnetconsulting.TimeTracking.GuiMVC.Models;
using dotnetconsulting.TimeTracking.Interfaces;
using dotnetconsulting.TimeTracking.Interfaces.Dtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace dotnetconsulting.TimeTracking.GuiMVC.Controllers;

public class TimeTrackingEntriesController : Controller
{
    private readonly IAppLogic _appLogic;
    private readonly IMapper _mapper;

    public TimeTrackingEntriesController(IAppLogic AppLogic,
                                         IMapper Mapper)
    {
        _appLogic = AppLogic;
        _mapper = Mapper;
    }

    // GET TimeTrackingEntries?s=07-01-2018&e=07-30-2018&order=99
    public async Task<IActionResult> Index(
        [FromQuery(Name = "s")] DateTime? Start,
        [FromQuery(Name = "e")] DateTime? End,
        [FromQuery(Name = "order")] int? OrderId,
        CancellationToken cancellationToken)
    {
        // Daten abfragen
        var listData = await _appLogic.GetTimeTrackingEntriesAsync(Start, End, OrderId, cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();
        var listOrder = await _appLogic.GetOrdersAsync(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // ViewModel erzeugen
        TimeTrackingIndexViewModel viewModel = new()
        {
            List = _mapper.Map<IEnumerable<Models.TimeTrackingEntryViewModel>>(listData),
            Orders = _mapper.Map<IEnumerable<SelectListItem>>(listOrder),

            FilterStart = Start,
            FilterEnd = End,
            OrderId = OrderId
        };

        // Übergaben an View
        return View(viewModel);
    }

    // GET: TimeTrackingEntries/Create
    public async Task<IActionResult> Create(CancellationToken cancellationToken)
    {
        EntryDto trackingEntry = await _appLogic.CreateNewTrackingEntryAsync(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();
        IList<OrderDto> listOrder = await _appLogic.GetOrdersAsync(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // ViewModel erzeugen
        TimeTrackingEditViewModel viewModel = _mapper.Map<TimeTrackingEditViewModel>(trackingEntry);
        viewModel.Orders = _mapper.Map<IEnumerable<SelectListItem>>(listOrder);

        // Das Dto kennt kein null, daher werden die 
        // Werte hier per Code gesetzt
        viewModel.OrderId = null;
        viewModel.Start = null;
        viewModel.End = null;
        viewModel.Break = null;

        // Jetzt weiter mit dem View für 'Edit'
        return View(nameof(Edit), viewModel);
    }

    // GET: TimeTrackingEntries/Edit/5
    public async Task<IActionResult> Edit(int id, CancellationToken cancellationToken)
    {
        EntryDto trackingEntry = await _appLogic.GetTimeTrackingEntryAsync(id, cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();
        IList<OrderDto> listOrder = await _appLogic.GetOrdersAsync(cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        // ViewModel erzeugen
        TimeTrackingEditViewModel viewModel = _mapper.Map<TimeTrackingEditViewModel>(trackingEntry);
        viewModel.Orders = _mapper.Map<IEnumerable<SelectListItem>>(listOrder);

        return View(viewModel);
    }

    // POST: TimeTrackingEntries/Edit
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(TimeTrackingEditViewModel viewModel, CancellationToken cancellationToken)
    {
        if (ModelState.IsValid)
        {
            EntryDto entryDto = _mapper.Map<EntryDto>(viewModel);
            await _appLogic.StoreTimeTrackingAsync(entryDto, cancellationToken).ConfigureAwait(false);
            cancellationToken.ThrowIfCancellationRequested();

            return RedirectToAction(nameof(Index));
        }
        else
        {
            // Inhalt der Unter-ViewModel wird nicht gepostet, weil nicht nötig
            var listOrder = await _appLogic.GetOrdersAsync(cancellationToken).ConfigureAwait(false);
            cancellationToken.ThrowIfCancellationRequested();

            viewModel.Orders = _mapper.Map<IEnumerable<SelectListItem>>(listOrder);

            return View(viewModel);
        }
    }

    // GET: TimeTrackingEntries/Delete/5
    [HttpGet]
    public async Task<IActionResult> Delete(int id, CancellationToken cancellationToken)
    {
        await _appLogic.DeleteTimeTrackingAsync(id, cancellationToken).ConfigureAwait(false);
        cancellationToken.ThrowIfCancellationRequested();

        return RedirectToAction("Index");
    }
}