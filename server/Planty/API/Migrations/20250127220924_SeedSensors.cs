using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API.Migrations
{
    /// <inheritdoc />
    public partial class SeedSensors : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "sensors",
                column: "port",
                values: new object[]
                {
                    "A0",
                    "A3",
                    "A4",
                    "A5"
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "sensors",
                keyColumn: "port",
                keyValue: "A0");

            migrationBuilder.DeleteData(
                table: "sensors",
                keyColumn: "port",
                keyValue: "A3");

            migrationBuilder.DeleteData(
                table: "sensors",
                keyColumn: "port",
                keyValue: "A4");

            migrationBuilder.DeleteData(
                table: "sensors",
                keyColumn: "port",
                keyValue: "A5");
        }
    }
}
