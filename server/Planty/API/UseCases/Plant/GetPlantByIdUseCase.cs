using API.Repositories;

namespace API.UseCases.Plant {
    public class GetPlantByIdUseCase {
        private readonly IPlantRepository plantRepository;

        public GetPlantByIdUseCase(IPlantRepository plantRepository) {
            this.plantRepository = plantRepository;
        }

        public async Task<Entities.Plant> Execute(Guid id) {
            try {
                return await plantRepository.GetById(id);
            }catch (Exception ex) {
                throw new Exception("Planta não cadastrada");
            }
        }
    }
}
