using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

namespace dotnetconsulting.EFCore.Data.Migrations
{
    public partial class AlternateKey : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Tag",
                table: "SpeakerSession",
                unicode: false,
                maxLength: 20,
                nullable: false,
                oldClrType: typeof(string),
                oldUnicode: false,
                oldMaxLength: 20,
                oldDefaultValue: "#TechEvent");

            migrationBuilder.AddUniqueConstraint(
                name: "AK_SpeakerSession_Tag",
                table: "SpeakerSession",
                column: "Tag");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropUniqueConstraint(
                name: "AK_SpeakerSession_Tag",
                table: "SpeakerSession");

            migrationBuilder.AlterColumn<string>(
                name: "Tag",
                table: "SpeakerSession",
                unicode: false,
                maxLength: 20,
                nullable: false,
                defaultValue: "#TechEvent",
                oldClrType: typeof(string),
                oldUnicode: false,
                oldMaxLength: 20);
        }
    }
}
