using API.Repositories;

namespace API.UseCases.Plant {
    public class DeletePlantUseCase {

        private readonly IPlantRepository plantRepository;

        public DeletePlantUseCase(IPlantRepository plantRepository) { 
            this.plantRepository = plantRepository;
        }

        public async Task<Entities.Plant> Execute(Guid plantId) {
            try {
                return await plantRepository.Delete(plantId);
            }catch (Exception ex) {
                throw new Exception("Falha ao deletar planta");
            }
        }

    }
}
