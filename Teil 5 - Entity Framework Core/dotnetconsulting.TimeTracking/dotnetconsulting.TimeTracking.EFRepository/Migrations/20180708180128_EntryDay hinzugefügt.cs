using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace dotnetconsulting.TimeTracking.EFRepository.Migrations
{
    public partial class EntryDayhinzugefügt : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "Day",
                schema: "TimeTracking",
                table: "Entries",
                nullable: false,
                defaultValueSql: "getdate()");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Day",
                schema: "TimeTracking",
                table: "Entries");
        }
    }
}
