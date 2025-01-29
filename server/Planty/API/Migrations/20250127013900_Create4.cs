using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API.Migrations
{
    /// <inheritdoc />
    public partial class Create4 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_plants_sensors_sensor_id",
                table: "plants");

            migrationBuilder.DropIndex(
                name: "IX_plants_sensor_id",
                table: "plants");

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
    }
}
