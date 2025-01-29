using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API.Migrations
{
    /// <inheritdoc />
    public partial class SensorPort : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_plants_sensors_sensor_id",
                table: "plants");

            migrationBuilder.DropPrimaryKey(
                name: "PK_sensors",
                table: "sensors");

            migrationBuilder.DropIndex(
                name: "IX_plants_sensor_id",
                table: "plants");

            migrationBuilder.DropColumn(
                name: "id",
                table: "sensors");

            migrationBuilder.DropColumn(
                name: "sensor_id",
                table: "plants");

            migrationBuilder.AddColumn<string>(
                name: "port",
                table: "sensors",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "sensor_port",
                table: "plants",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddPrimaryKey(
                name: "PK_sensors",
                table: "sensors",
                column: "port");

            migrationBuilder.CreateIndex(
                name: "IX_plants_sensor_port",
                table: "plants",
                column: "sensor_port",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_plants_sensors_sensor_port",
                table: "plants",
                column: "sensor_port",
                principalTable: "sensors",
                principalColumn: "port",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_plants_sensors_sensor_port",
                table: "plants");

            migrationBuilder.DropPrimaryKey(
                name: "PK_sensors",
                table: "sensors");

            migrationBuilder.DropIndex(
                name: "IX_plants_sensor_port",
                table: "plants");

            migrationBuilder.DropColumn(
                name: "port",
                table: "sensors");

            migrationBuilder.DropColumn(
                name: "sensor_port",
                table: "plants");

            migrationBuilder.AddColumn<Guid>(
                name: "id",
                table: "sensors",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<Guid>(
                name: "sensor_id",
                table: "plants",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddPrimaryKey(
                name: "PK_sensors",
                table: "sensors",
                column: "id");

            migrationBuilder.CreateIndex(
                name: "IX_plants_sensor_id",
                table: "plants",
                column: "sensor_id",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_plants_sensors_sensor_id",
                table: "plants",
                column: "sensor_id",
                principalTable: "sensors",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
