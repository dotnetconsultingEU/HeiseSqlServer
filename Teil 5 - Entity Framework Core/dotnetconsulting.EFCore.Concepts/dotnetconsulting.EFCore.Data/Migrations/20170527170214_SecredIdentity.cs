using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Metadata;

namespace dotnetconsulting.EFCore.Data.Migrations
{
    public partial class SecredIdentity : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "SecredIdentityId",
                table: "Speakers",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "SecredIdentity",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    SecredName = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SecredIdentity", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Speakers_SecredIdentityId",
                table: "Speakers",
                column: "SecredIdentityId");

            migrationBuilder.AddForeignKey(
                name: "FK_Speakers_SecredIdentity_SecredIdentityId",
                table: "Speakers",
                column: "SecredIdentityId",
                principalTable: "SecredIdentity",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Speakers_SecredIdentity_SecredIdentityId",
                table: "Speakers");

            migrationBuilder.DropTable(
                name: "SecredIdentity");

            migrationBuilder.DropIndex(
                name: "IX_Speakers_SecredIdentityId",
                table: "Speakers");

            migrationBuilder.DropColumn(
                name: "SecredIdentityId",
                table: "Speakers");
        }
    }
}
