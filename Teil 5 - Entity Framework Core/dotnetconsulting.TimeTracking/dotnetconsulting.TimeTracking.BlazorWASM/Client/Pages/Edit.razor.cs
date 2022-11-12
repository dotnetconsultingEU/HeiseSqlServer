// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.TimeTracking.BlazorWASM.Shared;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Forms;
using System.Diagnostics;
using System.Net.Http.Json;

namespace dotnetconsulting.TimeTracking.BlazorWASM.Client.Pages;

public class EditBase : PageBase
{
    [Inject]
    public HttpClient http { get; set; } = null!;

    [Inject]
    public NavigationManager navManager { get; set; } = null!;

    public Order[] Orders = null!;
    public Entry Entry = null!;

    [Parameter]
    public int Id { get; set; }

    public EditContext EditContext { get; set; } = null!;

    public bool IsNewEntry => Id == 0;

    #region Initialisierung
    protected override async Task OnInitializedAsync()
    {
        try
        {
            await loadEntry();
            EditContext = new EditContext(Entry);
            await loadOrders();
        }
        catch (Exception)
        {
            await DisplayAlert("Fehler beim Laden");
            // Navigation zur Übersicht
            navManager.NavigateTo("/");
        }
    }
    private async Task loadEntry()
    {
        if (IsNewEntry)
        {
            Entry = new Entry()
            {
                Start = new DateTime(2020, 1, 1, 9, 0, 0),
                End = new DateTime(2020, 1, 1, 17, 0, 0),
                Break = new DateTime(2020, 1, 1, 1, 0, 0),
                Day = DateTime.Today,
                Description = null!,
                Place = null!,
                OrderId = 0
            };
        }
        else
            Entry = (await http.GetFromJsonAsync<Entry>($"TimeTracking/Entry?Id={Id}"))!;
    }
    private async Task loadOrders()
    {
        // Daten laden 
        var data = (await http.GetFromJsonAsync<Order[]>("TimeTracking/Orders"))!;

        // Ein Element für "Alle Bestellungen" / "Bitte auswählen" einfügen
        Order[] completeOrders = new Order[data.Length + 1];
        completeOrders[0] = new Order()
        {
            Id = 0,
            Caption = IsNewEntry ? "(Bitte auswählen)" : "(Alle)"
        };
        Array.Copy(data, 0, completeOrders, 1, data.Length);
        Orders = completeOrders;
    }
    #endregion

    #region Storing
    public async Task StoreEntry()
    {
        try
        {
            // ToDo: Bad Request!? ASP.NET 6.0 RC Problem?
            HttpResponseMessage response = await http.PostAsJsonAsync("TimeTracking/Entry", Entry);
            response.EnsureSuccessStatusCode();
        }
        catch (Exception ex)
        {
            await DisplayAlert(ex);
        }
    }
    #endregion

    #region Form submitting
    public async Task FormValidSubmitted()
    {
        // Submit, wenn Eingaben gültig sind

        // Eingaben korrekt, speichern
        await StoreEntry();

        // Navigation zur Übersicht
        navManager.NavigateTo("/");
    }

#pragma warning disable CA1822 // Mark members as static
    public void FormInvalidSubmitted()
    {
        // Submit, wenn Eingaben ungültig sind
        Debug.Print("FormInvalidSubmitted");
    }
#pragma warning restore CA1822 // Mark members as static

    public async Task FormSubmitted()
    {
        // Generelles Submit, egal ob die Eingaben gültig sind oder nicht
        Debug.Print("FormSubmitted");

        // Bestehender Eintrag oder verändert
        if (IsNewEntry || EditContext.IsModified())
        {
            if (EditContext.Validate())
            {
                // Serverseitige Validierung
                SimpleResult<bool> anyEntryOnDate = (await http.GetFromJsonAsync<SimpleResult<bool>>($"TimeTracking/AnyEntryOnDate?date={Entry.Day.Ticks}&Id={Id}"))!;

                if (anyEntryOnDate.Value)
                {
                    await DisplayAlert("An diesem Tag wurde bereits ein Eintrag erfasst.");
                    return;
                }

                // Eingaben korrekt, speichern
                await StoreEntry();

                // Eigentlich unnötigt, hier nur zur Demo
                EditContext.MarkAsUnmodified();
            }
            else
                // Eingabe weiter bearbeiten
                return;
        }

        // Navigation zur Übersicht
        navManager.NavigateTo("/");
    }
}
#endregion