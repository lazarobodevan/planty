using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API.Migrations
{
    /// <inheritdoc />
    public partial class PlantReadingFK : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "plant_id",
                table: "plant_readings",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<string>(
                name: "sensor_port",
                table: "plant_readings",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateIndex(
                name: "IX_plant_readings_plant_id",
                table: "plant_readings",
                column: "plant_id");

            migrationBuilder.CreateIndex(
                name: "IX_plant_readings_sensor_port",
                table: "plant_readings",
                column: "sensor_port");

            migrationBuilder.AddForeignKey(
                name: "FK_plant_readings_plants_plant_id",
                table: "plant_readings",
                column: "plant_id",
                principalTable: "plants",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_plant_readings_sensors_sensor_port",
                table: "plant_readings",
                column: "sensor_port",
                principalTable: "sensors",
                principalColumn: "port",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_plant_readings_plants_plant_id",
                table: "plant_readings");

            migrationBuilder.DropForeignKey(
                name: "FK_plant_readings_sensors_sensor_port",
                table: "plant_readings");

            migrationBuilder.DropIndex(
                name: "IX_plant_readings_plant_id",
                table: "plant_readings");

            migrationBuilder.DropIndex(
                name: "IX_plant_readings_sensor_port",
                table: "plant_readings");

            migrationBuilder.DropColumn(
                name: "plant_id",
                table: "plant_readings");

            migrationBuilder.DropColumn(
                name: "sensor_port",
                table: "plant_readings");
        }
    }
}
