using API.Entities;
using API.Repositories;

namespace API.UseCases.PlantReadingUseCase {
    public class GetPlantReadingsBySensorIdUseCase {
        private readonly IPlantReadingRepository plantReadingRepository;

        public GetPlantReadingsBySensorIdUseCase(IPlantReadingRepository plantReadingRepository) {
            this.plantReadingRepository = plantReadingRepository;
        }

        public List<PlantReading> Execute(string sensorId) {
            return plantReadingRepository.GetBySensorId(sensorId);
        }
    }
}
