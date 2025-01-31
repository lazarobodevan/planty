using API.Dtos.Plant;
using API.Repositories;
using API.Services;

namespace API.UseCases.Plant {
    public class GetPlantsUseCase {

        private readonly IPlantRepository plantRepository;
        private readonly ISerialService serialService;

        public GetPlantsUseCase(IPlantRepository plantRepository, ISerialService serialService) { 
            this.plantRepository = plantRepository;
            this.serialService = serialService;
        }

        public  List<GetPlantDTO> Execute() {

            if(!serialService.IsPortOpen()) { throw new Exception("Falha ao se conectar a placa"); }

            var plants =  plantRepository.GetAll();
            List<GetPlantDTO> plantsDTO = new List<GetPlantDTO>();

            foreach (var plant in plants) {
                plantsDTO.Add(new GetPlantDTO {
                    Id = plant.Id,
                    Name = plant.Name,
                    Description = plant.Description,
                    IdealLightExposure = plant.IdealLightExposure,
                    CurrentLightExposure = serialService.Lux,
                    IdealTemperatureCelsius = plant.IdealTemperatureCelsius,
                    CurrentTemperatureCelsius = serialService.Temperature,
                    IdealMoisturePercentage = plant.IdealMoisturePercentage,
                    CurrentMoisturePercentage = serialService.Moistures[plant.SensorPort],
                    SensorPort = plant.SensorPort,
                });
            }
            return plantsDTO;
        }
    }
}
