// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using AutoMapper;
using dotnetconsulting.TimeTracking.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;

namespace dotnetconsulting.TimeTracking.GuiRazorPages.Pages.TimeTrackingEntries;

public class IndexModel : PageModel
{
    private readonly IAppLogic _appLogic;
    private readonly IMapper _mapper;

    public IndexModel(IAppLogic AppLogic, IMapper Mapper)
    {
        _appLogic = AppLogic;
        _mapper = Mapper;
    }

    #region ViewModel
    public IEnumerable<TimeTrackingEntryViewModel> List { get; set; } = null!;

    public IEnumerable<SelectListItem> Orders { get; set; } = null!;

    [Display(Name = "Auftrag")]
    public int? OrderId { get; set; }

    [Display(Name = "Von")]
    [DataType(DataType.Date)]
    [DisplayFormat(ConvertEmptyStringToNull = true)]
    public DateTime? FilterStart { get; set; }

    [Display(Name = "Bis")]
    [DataType(DataType.Date)]
    [DisplayFormat(ConvertEmptyStringToNull = true)]
    public DateTime? FilterEnd { get; set; }

    public class TimeTrackingEntryViewModel
    {
        public int Id { get; set; }

        [Display(Name = "Auftrag")]
        public string CustomerAndOrder { get; set; } = null!;

        [Display(Name = "Start")]
        [DisplayFormat(DataFormatString = @"{0:hh\:mm}", ApplyFormatInEditMode = true)]
        public TimeSpan Start { get; set; }

        [Display(Name = "Ende")]
        [DisplayFormat(DataFormatString = @"{0:hh\:mm}", ApplyFormatInEditMode = true)]
        public TimeSpan End { get; set; }

        [Display(Name = "Pause")]
        [DisplayFormat(DataFormatString = @"{0:hh\:mm}")]
        public TimeSpan Break { get; set; }

        [Display(Name = "Dauer")]
        [DisplayFormat(DataFormatString = @"{0:hh\:mm}")]
        public TimeSpan Duration => (End - Start - Break);

        [Display(Name = "Buchung am")]
        [DataType(DataType.Date)]
        public DateTime Day { get; set; }

        [Display(Name = "Ort")]
        public string Place { get; set; } = null!;

        [Display(Name = "Beschreibung")]
        public string Description { get; set; } = null!;
    }
    #endregion

    public async Task OnGetAsync([FromQuery(Name = "s")] DateTime? Start, [FromQuery(Name = "e")] DateTime? End, [FromQuery(Name = "order")] int? OrderId, CancellationToken cancellationToken)
    {
        // Daten abfragen
        var listData = await _appLogic.GetTimeTrackingEntriesAsync(Start, End, OrderId, cancellationToken);
        var listOrder = await _appLogic.GetOrdersAsync(cancellationToken);

        // ViewModel erzeugen
        List = _mapper.Map<IEnumerable<TimeTrackingEntryViewModel>>(listData);
        Orders = _mapper.Map<IEnumerable<SelectListItem>>(listOrder);

        FilterStart = Start;
        FilterEnd = End;
        this.OrderId = OrderId;

        // Fertig
        return;
    }

    public async Task<IActionResult> OnGetDeleteAsync(int id, CancellationToken cancellationToken)
    {
        await _appLogic.DeleteTimeTrackingAsync(id, cancellationToken);

        return RedirectToPage();
    }
}