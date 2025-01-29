using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API.Migrations
{
    /// <inheritdoc />
    public partial class Create2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_sensors_plants_Id",
                table: "sensors");

            migrationBuilder.AddColumn<Guid>(
                name: "SensorId",
                table: "plants",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_plants_SensorId",
                table: "plants",
                column: "SensorId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_plants_sensors_SensorId",
                table: "plants",
                column: "SensorId",
                principalTable: "sensors",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_plants_sensors_SensorId",
                table: "plants");

            migrationBuilder.DropIndex(
                name: "IX_plants_SensorId",
                table: "plants");

            migrationBuilder.DropColumn(
                name: "SensorId",
                table: "plants");

            migrationBuilder.AddForeignKey(
                name: "FK_sensors_plants_Id",
                table: "sensors",
                column: "Id",
                principalTable: "plants",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
