using Microsoft.EntityFrameworkCore.Migrations;

namespace dotnetconsulting.TimeTracking.EFRepository.Migrations
{
    public partial class OrderDescription : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Description",
                schema: "TimeTracking",
                table: "Orders",
                unicode: false,
                maxLength: 50,
                nullable: true);

            migrationBuilder.AlterColumn<bool>(
                name: "IsActive",
                schema: "TimeTracking",
                table: "Customers",
                nullable: false,
                defaultValue: true,
                oldClrType: typeof(bool));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Description",
                schema: "TimeTracking",
                table: "Orders");

            migrationBuilder.AlterColumn<bool>(
                name: "IsActive",
                schema: "TimeTracking",
                table: "Customers",
                nullable: false,
                oldClrType: typeof(bool),
                oldDefaultValue: true);
        }
    }
}
