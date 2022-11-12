// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using AutoMapper;
using dotnetconsulting.TimeTracking.BlazorWASM.Shared;
using dotnetconsulting.TimeTracking.Interfaces.Dtos;
using System;

namespace dotnetconsulting.TimeTracking.BlazorWASM.Server
{
    public class AutomapperProfile : Profile
    {
        public AutomapperProfile()
        {
            CreateMap<OrderDto, Order>()
                .ForMember(p => p.Caption, o => o.MapFrom(src => $"{src.OrderNr} ({src.Customer.Displayname})"));

            CreateMap<EntryDto, Entry>()
                .ForMember(p => p.Start, o => o.MapFrom(src => DateTime.Today.Add(src.Start)))
                .ForMember(p => p.End, o => o.MapFrom(src => DateTime.Today.Add(src.End)))
                .ForMember(p => p.Break, o => o.MapFrom(src => DateTime.Today.Add(src.Break)));

            CreateMap<Entry, EntryDto>()
                .ForMember(p => p.Start, o => o.MapFrom(src => new TimeSpan(src.Start.Hour, src.Start.Minute, src.Start.Second)))
                .ForMember(p => p.End, o => o.MapFrom(src => new TimeSpan(src.End.Hour, src.End.Minute, src.End.Second)))
                .ForMember(p => p.Break, o => o.MapFrom(src => new TimeSpan(src.Break.Hour, src.Break.Minute, src.Break.Second)));

            CreateMap<CustomerDto, Customer>().ReverseMap();
        }
    }
}