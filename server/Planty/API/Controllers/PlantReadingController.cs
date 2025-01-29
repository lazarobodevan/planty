using API.Repositories;
using API.UseCases.PlantReadingUseCase;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class PlantReadingController : ControllerBase {

        private readonly IPlantReadingRepository plantReadingRepository;
        private readonly GetPlantReadingsBySensorIdUseCase plantReadingUseCase;

        public PlantReadingController(IPlantReadingRepository plantReadingRepository) {
            this.plantReadingRepository = plantReadingRepository;
            this.plantReadingUseCase = new GetPlantReadingsBySensorIdUseCase(plantReadingRepository);
        }

        [HttpGet("sensorId={sensorId}")]
        public IActionResult GetPlantReadingsBySensorId([FromRoute] string sensorId) {
            try {
                var readings = plantReadingUseCase.Execute(sensorId);
                return Ok(readings);
            }catch (Exception ex) {
                return new BadRequestObjectResult(new { erro = ex.Message });
            }
        }


    }
}
