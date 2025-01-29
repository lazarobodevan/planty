using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API.Migrations
{
    /// <inheritdoc />
    public partial class Create3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_plants_sensors_SensorId",
                table: "plants");

            migrationBuilder.DropIndex(
                name: "IX_plants_SensorId",
                table: "plants");

            migrationBuilder.RenameColumn(
                name: "Moisture",
                table: "water_readings",
                newName: "moisture");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "water_readings",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "CreatedAt",
                table: "water_readings",
                newName: "created_at");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "sensors",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "plants",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "Description",
                table: "plants",
                newName: "description");

            migrationBuilder.RenameColumn(
                name: "SensorId",
                table: "plants",
                newName: "sensor_id");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "plant_readings",
                newName: "id");

            migrationBuilder.AddColumn<Guid>(
                name: "sensor_id1",
                table: "plants",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_plants_sensor_id1",
                table: "plants",
                column: "sensor_id1",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_plants_sensors_sensor_id1",
                table: "plants",
                column: "sensor_id1",
                principalTable: "sensors",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_plants_sensors_sensor_id1",
                table: "plants");

            migrationBuilder.DropIndex(
                name: "IX_plants_sensor_id1",
                table: "plants");

            migrationBuilder.DropColumn(
                name: "sensor_id1",
                table: "plants");

            migrationBuilder.RenameColumn(
                name: "moisture",
                table: "water_readings",
                newName: "Moisture");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "water_readings",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "created_at",
                table: "water_readings",
                newName: "CreatedAt");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "sensors",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "name",
                table: "plants",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "description",
                table: "plants",
                newName: "Description");

            migrationBuilder.RenameColumn(
                name: "sensor_id",
                table: "plants",
                newName: "SensorId");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "plant_readings",
                newName: "Id");

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
    }
}
