using API.Dtos.PlantReading;
using API.Entities;
using API.Repositories;

namespace API.UseCases.PlantReadingUseCase {
    public class GetPlantReadingsBySensorIdUseCase {
        private readonly IPlantReadingRepository plantReadingRepository;

        public GetPlantReadingsBySensorIdUseCase(IPlantReadingRepository plantReadingRepository) {
            this.plantReadingRepository = plantReadingRepository;
        }

        public PlantReadingsReponseDTO? Execute(string sensorId) {
            var readings =  plantReadingRepository.GetBySensorId(sensorId);

            if (readings.Count == 0) return null;

            var responseDTO = new PlantReadingsReponseDTO {
                PlantId = readings[0].PlantId,
                SensorPort = sensorId,
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
