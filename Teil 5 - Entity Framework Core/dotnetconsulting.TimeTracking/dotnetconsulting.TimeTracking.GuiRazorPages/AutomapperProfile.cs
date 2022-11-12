// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using AutoMapper;
using dotnetconsulting.TimeTracking.Interfaces.Dtos;
using Microsoft.AspNetCore.Mvc.Rendering;
using static dotnetconsulting.TimeTracking.GuiRazorPages.Pages.TimeTrackingEntries.IndexModel;

namespace dotnetconsulting.TimeTracking.GuiRazorPages;

public class AutomapperProfile : Profile
{
    public AutomapperProfile()
    {
        CreateMap<EntryDto, TimeTrackingEntryViewModel>().
            ForMember(p => p.CustomerAndOrder,
            o => o.MapFrom(src => $"{src.Order.OrderNr} ({src.Order.Customer.Displayname})"));

        CreateMap<EntryDto, Pages.TimeTrackingEntries.EditModel>().ReverseMap();

        CreateMap<OrderDto, SelectListItem>()
            .ForMember(p => p.Value,
            o => o.MapFrom(src => src.Id))
            .ForMember(p => p.Text,
            o => o.MapFrom(src => $"{src.OrderNr} ({src.Customer.Displayname})"));
    }
}