// Disclaimer
// Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
// Auflagen oder Einschränkungen verwendet oder verändert werden.
// Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
// zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
// Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
// Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

// Thorsten Kansy, www.dotnetconsulting.eu

using dotnetconsulting.EFCore.CosmosDb;
using dotnetconsulting.EFCore.Domains;
using dotnetconsulting.EFCore.DomainsGuid;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace dotnetconsulting.EFCore.CosmosDbSql
{
    class Program
    {
#pragma warning disable IDE0051 // Remove unused private members

        static void Main()
        {
            EFLoggerFactory.SetupFactory(LogLevel.Trace);

            // Demos mit Integer als UniqueKey
            // CreateWithInt();
            // QueryWithInt();
            // UpdateWithInt();
            // DeleteWithInt();

            // Demos mit Guid as UniqueKey
            // CreateDatabaseWithGuid();
            // CreateWithGuid();
            QueryWithGuid();
            UpdateWithGuid();
            // DeleteWithGuid();

            // Demos mit Owned Types
            // createOrders();
            // queryOrder();

            Console.WriteLine("== Fertig ==");
            Console.ReadKey();
        }

        #region UniqueKey: Guid
        private static void CreateDatabaseWithGuid()
        {
            // Debugger.Break();

            using CosmosDbContextGuid context = new();
            context.Database.EnsureCreated();
        }
        private static void CreateWithGuid()
        {
            Debugger.Break();

            using CosmosDbContextGuid context = new();
            // TechEvent anlegen
            TechEventGuid techEvent = new()
            {
                LocationCountry = "Lummerland",
                LocationCity = "Central City",
                Name = "DNC 2019"
            };

            for (int j = 0; j < 2; j++)
            {
                // Sprecher anlegen
                SpeakerGuid speaker = new()
                {
                    Name = $"Speaker {j}",
                    WebSite = "http://www.dotnetconsulting.eu"
                };

                speaker.MainExperience.Topic = ".NET Core & SQL Server";
                speaker.MainExperience.Details = "...";

                for (int i = 0; i < 2; i++)
                {
                    Experience experience = new()
                    {
                        Topic = $"Topic: {i}",
                        Details = $"Details: {i}"
                    };

                    speaker.Experiences.Add(experience);
                }

                for (int i = 0; i < 2; i++)
                {
                    // Session anlegen
                    SessionGuid session = new()
                    {
                        Name = $"Session {i}",
                        TechEvent = techEvent,
                        Difficulty = DomainsGuid.DifficultyLevel.Level3
                    };

                    // m:n Speaker-Session anlegen
                    SpeakerSessionGuid speakerSession = new()
                    {
                        Speaker = speaker,
                        Session = session
                    };

                    context.Add(speakerSession);
                }

                context.Add(speaker);
            }

            context.SaveChanges();
        }

        private static void QueryWithGuid()
        {
            Debugger.Break();

            using CosmosDbContextGuid context = new();
            //SpeakerGuid speaker = context.Speakers
            //    .Include(i => i.SpeakerSessions)
            //    .ThenInclude(t => t.Session)
            //    .Where(w => w.Name == "Speaker 0")
            //    .FirstOrDefault();

            //SpeakerGuid speaker = context.Speakers
            //    .Where(w => w.Name == "Speaker 0")
            //    .ToList()
            //    .FirstOrDefault();
            //dumpObject(speaker);

            int c = context.TechEvents.Count();

            TechEventGuid techevent = context.TechEvents
                .Find(new Guid("45e2e7c2-8a2e-4b64-9273-296d4012c802"));


            DumpObject(techevent);
        }

        private static void UpdateWithGuid()
        {
            Debugger.Break();

            // where c.Discriminator = 'SpeakerGuid' 
            // where c.Name = 'Hugo Hirsch'
            using CosmosDbContextGuid context = new();
            // Bsp: a4b46bfa-3a9c-4bb6-8a8f-a715f8e287ff
            Guid id = new("a4b46bfa-3a9c-4bb6-8a8f-a715f8e287ff");

            // Ansatz 1
            SpeakerGuid speaker = context.Speakers.Find(id);
            if (speaker != null)
            {
                speaker.Name = "Hugo Hirsch";
            }
            context.SaveChangesAsync().Wait();

            // Ansatz 2
            speaker = context.Speakers.Where(w => w.Id == id && w.Name == "Hugo Hirsch").FirstOrDefault();
            if (speaker != null)
            {
                speaker.Name = "Jim Knopf";
            }
            context.SaveChangesAsync().Wait();
        }

        private static void DeleteWithGuid()
        {
            Debugger.Break();

            using CosmosDbContextGuid context = new();
            var query = context.Speakers;

            // Kein Casacading Delete
            // Keine referentielle Integrität
            // => es bleiben eventuell einige verwaiste Entitäten übrig
            context.Speakers.RemoveRange(query.ToList());

            context.SaveChangesAsync().Wait();
        }
        #endregion

        #region UniqueKey: Integer
        public static void CreateDatabaseWithInt()
        {
            Debugger.Break();

            using CosmosDbContext context = new();
            context.Database.EnsureCreated();
        }

        public static void CreateWithInt()
        {
            Debugger.Break();

            using CosmosDbContext context = new();
            // TechEvent anlegen
            TechEvent techEvent = new()
            {
                Id = CreateUniqueId(),
                LocationCountry = "Lummerland",
                LocationCity = "Central City",
                Name = "DNC 2019"
            };

            for (int j = 0; j < 2; j++)
            {
                // Sprecher anlegen
                Speaker speaker = new()
                {
                    Id = CreateUniqueId(),
                    Name = $"Speaker {j}",
                    WebSite = "http://www.dotnetconsulting.eu"
                };

                for (int i = 0; i < 2; i++)
                {
                    // Session anlegen
                    Session session = new()
                    {
                        Id = CreateUniqueId(),
                        Name = $"Session {i}",
                        TechEvent = techEvent,
                        Difficulty = Domains.DifficultyLevel.Level3
                    };

                    // m:n Speaker-Session anlegen
                    SpeakerSession speakerSession = new()
                    {
                        Speaker = speaker,
                        Session = session
                    };

                    context.Add(speakerSession);
                }

                context.Add(speaker);
            }

            context.SaveChangesAsync().Wait();
        }

        private static void QueryWithInt()
        {
            Debugger.Break();

            using CosmosDbContext context = new();
            Speaker speaker = context.Speakers
                .Include(i => i.SpeakerSessions)
                .ThenInclude(t => t.Session)
                .Where(w => w.Name == "Thorsten")
                .FirstOrDefault();

            DumpObject(speaker);
        }

        private static void UpdateWithInt()
        {
            Debugger.Break();

            // where c.Discriminator = 'Speaker' 
            // where c.Name = 'Hugo Hirsch'
            using CosmosDbContext context = new();
            // Bsp: 42
            int id = 4711;

            // Ansatz 1
            Speaker speaker = context.Speakers.Find(id);
            if (speaker != null)
            {
                speaker.Name = "Hugo Hirsch";
            }
            context.SaveChangesAsync().Wait();

            // Ansatz 2
            speaker = context.Speakers.Where(w => w.Id == id && w.Name == "Hugo Hirsch").FirstOrDefault();
            if (speaker != null)
            {
                speaker.Name = "Jim Knopf";
            }
            context.SaveChangesAsync().Wait();
        }

        private static void DeleteWithInt()
        {
            Debugger.Break();

            using CosmosDbContext context = new();
            var query = context.Speakers;

            // Kein Casacading Delete
            // Keine referentielle Integrität
            // => es bleien einige verwaiste Entitäten übrig
            context.Speakers.RemoveRange(query.ToList());

            context.SaveChangesAsync().Wait();
        }

        private static readonly Random rnd = new();
        private static int CreateUniqueId()
        {
            return rnd.Next(int.MinValue, int.MaxValue);
        }
        #endregion

        #region Owned Types
        private static void CreateOrders()
        {
            Debugger.Break();

            using (CosmosDbContextOwnedTypes context = new())
            {
                context.Database.EnsureCreated();
                for (int i = 1; i < 3; i++)
                {
                    Order order = createNewOrder();

                    context.Orders.Add(order);
                }

                context.SaveChanges();
            }

            static Order createNewOrder()
            {
                Random rnd = new();

                Order order = new()
                {

                    // (Liefer-)Adresse
                    ShippingAddress = new Address()
                    {
                        City = $"City {rnd.Next() % 4}",
                        Street = $"Wasserweg {(rnd.Next() % 50) + 1}",
                        Country = "Germany",
                        Zip = $"{rnd.Next(10000, 99999)}"
                    },

                    // Status
                    Status = (OrderStatus)(rnd.Next(0, 3) % 3),

                    // Bestellzeilen (Details)
                    OrderLines = new List<OrderLine>()
                };

                for (int i = 0; i < rnd.Next(5, 20); i++)
                {
                    OrderLine orderLine = new()
                    {
                        Amount = (decimal)rnd.NextDouble() * 100m,
                        Product = $"Product {i}",
                        ProductNr = i + 1,
                        Status = new OrderLineStatus()
                        {
                            IsOnStock = rnd.Next(0, 1) == 1,
                            ConfirmedBy = $"User {i + 1}"
                        }
                    };

                    order.OrderLines.Add(orderLine);
                };

                // Rückgabe 
                return order;
            }
        }

        private static void QueryOrder()
        {
            Debugger.Break();

            using CosmosDbContextOwnedTypes context = new();
            int count = context.Orders.Count();
        }
        #endregion

        private static void DumpObject(object @object)
        {
            // Console.Clear();
            Console.WriteLine(new string('=', 40));
            Console.WriteLine(JsonConvert.SerializeObject(@object,
                Formatting.Indented,
                new JsonSerializerSettings
                {
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                }));
            Console.WriteLine(new string('=', 40));
        }
    }
}