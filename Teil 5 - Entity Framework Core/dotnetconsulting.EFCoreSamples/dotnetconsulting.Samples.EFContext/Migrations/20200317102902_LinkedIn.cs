using Microsoft.EntityFrameworkCore.Migrations;

namespace dotnetconsulting.Samples.EFContext.Migrations
{
    public partial class LinkedIn : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "LinkedIn",
                schema: "dnc",
                table: "Speakers",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "LinkedIn",
                schema: "dnc",
                table: "Speakers");
        }
    }
}
