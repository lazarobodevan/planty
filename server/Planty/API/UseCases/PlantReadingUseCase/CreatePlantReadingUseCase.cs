using API.Entities;
using API.Repositories;

namespace API.UseCases.PlantReadingUseCase {
    public class CreatePlantReadingUseCase {
        private readonly IPlantReadingRepository plantReadingRepository;

        public CreatePlantReadingUseCase(IPlantReadingRepository plantReadingRepository) {
            this.plantReadingRepository = plantReadingRepository;
        }

        public async Task<PlantReading> Execute(PlantReading plantReading) {
            await plantReadingRepository.Create(plantReading);
            return plantReading;
        }
    }
}
