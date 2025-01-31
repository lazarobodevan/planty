using API.Dtos.Plant;
using API.Repositories;

namespace API.UseCases.Plant {
    public class UpdatePlantUseCase {
        private readonly IPlantRepository plantRepository;

        public UpdatePlantUseCase(IPlantRepository plantRepository) {
            this.plantRepository = plantRepository;
        }

        public async Task<Entities.Plant> Execute(Guid plantId, UpdatePlantDTO updatePlantDTO) {
            var foundPlant = await plantRepository.GetById(plantId);

            if(foundPlant == null) { throw new Exception("Planta não cadastrada"); }

            Entities.Plant updatePlant = new Entities.Plant {
                Id = foundPlant.Id,
                Name = updatePlantDTO.Name ?? foundPlant.Name,
                Description = updatePlantDTO.Description ?? foundPlant.Description,
                IdealLightExposure = updatePlantDTO.IdealLightExposure ?? foundPlant.IdealLightExposure,
                IdealMoisturePercentage = updatePlantDTO.IdealMoisturePercentage ?? foundPlant.IdealMoisturePercentage,
                IdealTemperatureCelsius = updatePlantDTO.IdealTemperatureCelsius ?? foundPlant.IdealTemperatureCelsius,
                SensorPort = updatePlantDTO.SensorPort ?? foundPlant.SensorPort,
            };

            return await plantRepository.Update(updatePlant);
        }
    }
}
