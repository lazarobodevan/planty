using API.Dtos.Plant;
using API.Repositories;
using API.Services;
using API.Services.Impl;
using API.UseCases.Plant;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.IO.Ports;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlantController : ControllerBase {

        private readonly CreatePlantUseCase createPlantUseCase;
        private readonly GetPlantByIdUseCase getPlantByIdUseCase;
        private readonly DeletePlantUseCase deletePlantByIdUseCase;
        private readonly GetPlantsUseCase getPlantsUseCase;
        private readonly UpdatePlantUseCase updatePlantUseCase;

        private readonly IPlantRepository plantRepository;
        private readonly ISensorRepository sensorRepository;

        private readonly ISerialService serialService;

        public PlantController(
            IPlantRepository plantRepository,
            ISensorRepository sensorRepository,
            ISerialService serialService
            ) {

            this.sensorRepository = sensorRepository;
            this.plantRepository = plantRepository;

            createPlantUseCase = new CreatePlantUseCase(plantRepository, sensorRepository);
            getPlantByIdUseCase = new GetPlantByIdUseCase(plantRepository);
            deletePlantByIdUseCase = new DeletePlantUseCase(plantRepository);
            getPlantsUseCase = new GetPlantsUseCase(plantRepository);
            updatePlantUseCase = new UpdatePlantUseCase(plantRepository);

            this.serialService = serialService;
        }

        [HttpPost("create")]
        public async Task<IActionResult> CreatePlantAsync([FromBody] CreatePlantDTO createPlantDTO) {

            try {
                var createdPlant = await createPlantUseCase.Execute(createPlantDTO);
                await serialService.SendConfig();

                return StatusCode(StatusCodes.Status201Created, createdPlant);
            }catch(Exception ex) {
                return new BadRequestObjectResult(new { erro = ex.Message });
            }
        }

        [HttpGet("fetch")]
        public async Task<IActionResult> GetPlantsAsync([FromQuery] Guid? plantId) {

            try {
                if (plantId.HasValue) {
                    var plant = await getPlantByIdUseCase.Execute(plantId.Value);

                    if (plant == null) throw new Exception("Planta não cadastrada");

                    return StatusCode(StatusCodes.Status200OK, plant);

                } else {
                    var plants = getPlantsUseCase.Execute();
                    return StatusCode(StatusCodes.Status200OK, plants);
                }
            } catch (Exception ex) {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("plantId={plantId}")]
        public async Task<IActionResult> DeletePlantAsync([FromRoute] string plantId) {
            try {
                var deletedPlant = await deletePlantByIdUseCase.Execute(Guid.Parse(plantId));
                serialService.UpdateSensor(deletedPlant.SensorPort, -1);
                return StatusCode(StatusCodes.Status200OK);
            }catch (Exception ex) {
                return new BadRequestObjectResult(new {erro = ex.Message});
            }
        }

        [HttpPut("update/plantId={plantId}")]
        public async Task<IActionResult> UpdatePlantAsync([FromRoute] Guid plantId, [FromBody] UpdatePlantDTO plantDTO) {
            try {
                var updatedPlant = await updatePlantUseCase.Execute(plantId, plantDTO);

                if (plantDTO.IdealMoisturePercentage != null) {
                    serialService.SendConfig();
                }

                return StatusCode(StatusCodes.Status200OK, updatedPlant);

            }catch (Exception ex) {

                return new BadRequestObjectResult(new {erro = ex.Message});
            }
        }

    }
}
