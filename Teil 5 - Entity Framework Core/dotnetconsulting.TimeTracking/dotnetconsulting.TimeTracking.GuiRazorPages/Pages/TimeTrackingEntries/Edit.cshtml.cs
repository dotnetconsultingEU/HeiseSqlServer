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
using dotnetconsulting.TimeTracking.Interfaces.Dtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;

namespace dotnetconsulting.TimeTracking.GuiRazorPages.Pages.TimeTrackingEntries
{
    public class EditModel : PageModel, IValidatableObject
    {
        private readonly IAppLogic _appLogic;
        private readonly IMapper _mapper;

        public EditModel(IAppLogic AppLogic, IMapper Mapper)
        {
            _appLogic = AppLogic;
            _mapper = Mapper;
        }

        #region ViewModel
        [HiddenInput]
        [BindProperty]
        public int Id { get; set; }

        public bool IsNewEntry => OrderId == null;

        public IEnumerable<SelectListItem> Orders { get; set; } = null!;

        [Display(Name = "Auftrag")]
        [Required]
        [BindProperty]
        public int? OrderId { get; set; }

        [Display(Name = "Start")]
        [DataType(DataType.Time)]
        [Required]
        [DisplayFormat(DataFormatString = @"{0:hh\:mm}", ApplyFormatInEditMode = true)]
        [BindProperty]
        public TimeSpan? Start { get; set; }

        [Display(Name = "Ende")]
        [DataType(DataType.Time)]
        [Required]
        [DisplayFormat(DataFormatString = @"{0:hh\:mm}", ApplyFormatInEditMode = true)]
        [BindProperty]
        public TimeSpan? End { get; set; }

        [Display(Name = "Pause")]
        [DataType(DataType.Duration)]
        [Required]
        [DisplayFormat(DataFormatString = @"{0:hh\:mm}")]
        [BindProperty]
        public TimeSpan? Break { get; set; }

        [Display(Name = "Buchung am")]
        [DataType(DataType.Date)]
        [Required]
        [BindProperty]
        public DateTime Day { get; set; }

        [Display(Name = "Ort")]
        [Required, MaxLength(50)]
        [BindProperty]
        public string Place { get; set; } = null!;

        [Display(Name = "Beschreibung")]
        [Required]
        [MaxLength(250)]
        [BindProperty]
        public string Description { get; set; } = null!;

        public IEnumerable<ValidationResult> Validate(System.ComponentModel.DataAnnotations.ValidationContext validationContext)
        {
            if (Start > End)
                yield return new ValidationResult("Start muss vor Ende liegen.", new string[] { nameof(Start), nameof(End) });

            if ((End - Start - Break)!.Value.TotalMinutes < 5)
                yield return new ValidationResult("Dauer muss mindestens 5 Minuten betragen.", Array.Empty<string>());
        }
        #endregion

        public async Task OnGetAsync(int Id, CancellationToken cancellationToken)
        {
            EntryDto trackingEntry = await _appLogic.GetTimeTrackingEntryAsync(Id, cancellationToken);
            IList<OrderDto> listOrder = await _appLogic.GetOrdersAsync(cancellationToken);

            // ViewModel erzeugen
            _mapper.Map(trackingEntry, this);
            Orders = _mapper.Map<IEnumerable<SelectListItem>>(listOrder);

            // Fertig
            return;
        }

        public async Task OnGetCreateAsync(CancellationToken cancellationToken)
        {
            EntryDto trackingEntry = await _appLogic.CreateNewTrackingEntryAsync(cancellationToken);
            IList<OrderDto> listOrder = await _appLogic.GetOrdersAsync(cancellationToken);

            // ViewModel erzeugen
            _mapper.Map(trackingEntry, this);
            Orders = _mapper.Map<IEnumerable<SelectListItem>>(listOrder);

            // Das Dto kennt kein null, daher werden die 
            // Werte hier per Code gesetzt
            OrderId = null;
            Start = null;
            End = null;
            Break = null;

            // Fertig
            return;
        }

        public async Task<IActionResult> OnPostAsync(CancellationToken cancellationToken)
        {
            if (ModelState.IsValid)
            {
                EntryDto entryDto = new();
                _mapper.Map(this, entryDto);
                await _appLogic.StoreTimeTrackingAsync(entryDto, cancellationToken);

                return RedirectToPage("Index");
            }
            else
            {
                // Inhalt des Unter-ViewModel wird nicht gepostet
                var listOrder = await _appLogic.GetOrdersAsync(cancellationToken);
                Orders = _mapper.Map<IEnumerable<SelectListItem>>(listOrder);

                return null!;
            }
        }
    }
}