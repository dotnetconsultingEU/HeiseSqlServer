using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Metadata;

namespace dotnetconsulting.EFCore.Data.Migrations
{
    public partial class Init : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Speakers",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Description = table.Column<string>(nullable: true),
                    Name = table.Column<string>(unicode: false, maxLength: 50, nullable: true, defaultValue: "???"),
                    WebSite = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Speakers", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "TechEvents",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    ImageUrl = table.Column<string>(nullable: true),
                    LocationCity = table.Column<string>(nullable: true),
                    LocationCountry = table.Column<string>(nullable: true),
                    Name = table.Column<string>(nullable: true),
                    OnlineUrl = table.Column<string>(nullable: true),
                    Price = table.Column<decimal>(nullable: false),
                    Start = table.Column<DateTime>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TechEvents", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Sessions",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Abstract = table.Column<string>(nullable: true),
                    Difficulty = table.Column<int>(nullable: false),
                    Duration = table.Column<int>(nullable: false),
                    EventId = table.Column<int>(nullable: true),
                    Name = table.Column<string>(nullable: true),
                    Presenter = table.Column<string>(nullable: true),
                    SpeakerId = table.Column<int>(nullable: false),
                    TechEventId = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Sessions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Sessions_TechEvents_TechEventId",
                        column: x => x.TechEventId,
                        principalTable: "TechEvents",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SpeakerSession",
                columns: table => new
                {
                    SessionId = table.Column<int>(nullable: false),
                    SpeakerId = table.Column<int>(nullable: false),
                    Tag = table.Column<string>(unicode: false, maxLength: 20, nullable: false, defaultValue: "#TechEvent")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SpeakerSession", x => new { x.SessionId, x.SpeakerId });
                    table.ForeignKey(
                        name: "FK_SpeakerSession_Sessions_SessionId",
                        column: x => x.SessionId,
                        principalTable: "Sessions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SpeakerSession_Speakers_SpeakerId",
                        column: x => x.SpeakerId,
                        principalTable: "Speakers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Sessions_TechEventId",
                table: "Sessions",
                column: "TechEventId");

            migrationBuilder.CreateIndex(
                name: "IX_SpeakerSession_SpeakerId",
                table: "SpeakerSession",
                column: "SpeakerId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "SpeakerSession");

            migrationBuilder.DropTable(
                name: "Sessions");

            migrationBuilder.DropTable(
                name: "Speakers");

            migrationBuilder.DropTable(
                name: "TechEvents");
        }
    }
}
