using API.Dtos.Plant;
using API.Repositories;

namespace API.UseCases.Plant {
    public class CreatePlantUseCase {

        private readonly IPlantRepository plantRepository;
        private readonly ISensorRepository sensorRepository;

        public CreatePlantUseCase(IPlantRepository plantRepository, ISensorRepository sensorRepository) {
            this.plantRepository = plantRepository;
            this.sensorRepository = sensorRepository;
        }

        public async Task<Entities.Plant> Execute(CreatePlantDTO plantDTO) {

            var isSensorAvailable = await sensorRepository.IsSensorAvailable(plantDTO.SensorPort);

            if(!isSensorAvailable) {
                throw new Exception("Sensor não está disponível");
            }

            var createdPlant = await plantRepository.Create(new Entities.Plant() {
                Id = Guid.NewGuid(),
                Description = plantDTO.Description,
                IdealLightExposure = plantDTO.IdealLightExposure,
                IdealMoisturePercentage = plantDTO.IdealMoisturePercentage,
                IdealTemperatureCelsius = plantDTO.IdealTemperatureCelsius,
                Name = plantDTO.Name,
                SensorPort = plantDTO.SensorPort
            });

            return createdPlant;

        }

    }
}
