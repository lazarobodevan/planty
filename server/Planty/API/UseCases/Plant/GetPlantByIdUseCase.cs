using API.Dtos.Plant;
using API.Repositories;
using API.Services;

namespace API.UseCases.Plant {
    public class GetPlantByIdUseCase {
        private readonly IPlantRepository plantRepository;
        private readonly ISerialService serialService;

        public GetPlantByIdUseCase(IPlantRepository plantRepository, ISerialService serialService) {
            this.plantRepository = plantRepository;
            this.serialService = serialService;
        }

        public async Task<GetPlantDTO> Execute(Guid id) {
            try {
                var plant = await plantRepository.GetById(id);
                return new GetPlantDTO {
                    Id = id,
                    Name = plant!.Name,
                    Description = plant!.Description,
                    IdealLightExposure = plant!.IdealLightExposure,
                    CurrentLightExposure = serialService.Lux,
                    IdealTemperatureCelsius = plant!.IdealTemperatureCelsius,
                    CurrentTemperatureCelsius = serialService.Temperature,
                    IdealMoisturePercentage = plant!.IdealMoisturePercentage,
                    CurrentMoisturePercentage = serialService.Moistures[plant!.SensorPort],
                    SensorPort = plant!.SensorPort,
                };
            }catch (Exception ex) {
                throw new Exception("Planta não cadastrada");
            }
        }
    }
}
