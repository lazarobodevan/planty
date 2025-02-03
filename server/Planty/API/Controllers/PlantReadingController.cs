using API.Repositories;
using API.UseCases.PlantReadingUseCase;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class PlantReadingController : ControllerBase {

        private readonly IPlantReadingRepository plantReadingRepository;
        private readonly IPlantRepository plantRepository;
        private readonly GetPlantReadingsBySensorIdUseCase plantReadingUseCase;

        public PlantReadingController(IPlantReadingRepository plantReadingRepository, IPlantRepository plantRepository) {
            this.plantReadingRepository = plantReadingRepository;
            this.plantRepository = plantRepository;
            this.plantReadingUseCase = new GetPlantReadingsBySensorIdUseCase(plantReadingRepository, plantRepository);
        }

        [HttpGet("sensorId={sensorId}")]
        public IActionResult GetPlantReadingsBySensorId([FromRoute] string sensorId) {
            try {
                var readings = plantReadingUseCase.Execute(sensorId);

                if(readings == null) {
                    return StatusCode(StatusCodes.Status404NotFound, new {erro = "Não há registros"});
                }
                return Ok(readings);
            }catch (Exception ex) {
                return new BadRequestObjectResult(new { erro = ex.Message });
            }
        }


    }
}
