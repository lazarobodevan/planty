using API.Dtos.PlantReading;
using API.Entities;
using API.Repositories;

namespace API.UseCases.PlantReadingUseCase {
    public class GetPlantReadingsBySensorIdUseCase {
        private readonly IPlantReadingRepository plantReadingRepository;
        private readonly IPlantRepository plantRepository;

        public GetPlantReadingsBySensorIdUseCase(IPlantReadingRepository plantReadingRepository, IPlantRepository plantRepository) {
            this.plantReadingRepository = plantReadingRepository;
            this.plantRepository = plantRepository;
        }

        public PlantReadingsReponseDTO Execute(string sensorPort) {

            List<PlantReading> readings = plantReadingRepository.GetBySensorId(sensorPort);
            Entities.Plant plant = plantRepository.GetBySensorPort(sensorPort);

            var responseDTO = new PlantReadingsReponseDTO {
                PlantId = plant.Id,
                PlantName = plant.Name,
                SensorPort = sensorPort,
                IdealLightExposure = plant.IdealLightExposure,
                IdealMoisturePercentage = plant.IdealMoisturePercentage,
                IdealTemperatureCelsius = plant.IdealTemperatureCelsius,
                Readings = new List<PlantReadingDTO>()
            };

            foreach (var reading in readings) {
                responseDTO.Readings.Add(new PlantReadingDTO {
                    Id = reading.Id,
                    Light = reading.Light,
                    Moisture = reading.Moisture,
                    TemperatureCelsius = reading.TemperatureCelsius,
                    CreatedAt = reading.CreatedAt,
                });
            }
            return responseDTO;
        }
    }
}
