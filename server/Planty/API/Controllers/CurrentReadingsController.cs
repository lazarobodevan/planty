using API.Dtos.Readings;
using API.Services;
using API.Services.Impl;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CurrentReadingsController : ControllerBase {

        private readonly ISerialService serialService;

        public CurrentReadingsController(ISerialService serialService) {
            this.serialService = serialService;
        }

        [HttpGet("fetch/current")]
        public IActionResult GetCurrentReadings([FromQuery] string? sensorId) {
            int? sensorMoisture = null;
            try {
                if (sensorId != null) {
                    sensorMoisture = serialService.Moistures[sensorId];
                }
                return StatusCode(StatusCodes.Status200OK, new CurrentReadingsDTO {
                    Lux = serialService.Lux,
                    Temperature = serialService.Temperature,
                    Moisture = sensorMoisture
                });
            } catch (Exception ex) {
                return StatusCode(StatusCodes.Status200OK, new CurrentReadingsDTO {
                    Lux = serialService.Lux,
                    Temperature = serialService.Temperature,
                });
            }

            
        }

    }
}
