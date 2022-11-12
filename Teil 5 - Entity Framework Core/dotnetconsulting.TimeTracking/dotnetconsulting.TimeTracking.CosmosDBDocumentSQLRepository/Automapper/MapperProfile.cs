﻿// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu
using AutoMapper;
using dotnetconsulting.TimeTracking.CosmosDBDocumentSQLRepository.ComosDB;
using dotnetconsulting.TimeTracking.Interfaces.Dtos;

namespace dotnetconsulting.TimeTracking.CosmosDBDocumentSQLRepository.Automapper;

public class MapperProfile : Profile
{
    public MapperProfile()
    {
        CreateMap<Entry, EntryDto>().ReverseMap();
        CreateMap<Entry, Entry>();
        CreateMap<Order, OrderDto>().ReverseMap();
        CreateMap<Customer, CustomerDto>().ReverseMap();
    }
}