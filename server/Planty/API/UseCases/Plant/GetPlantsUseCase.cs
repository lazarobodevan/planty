using API.Repositories;

namespace API.UseCases.Plant {
    public class GetPlantsUseCase {

        private readonly IPlantRepository plantRepository;

        public GetPlantsUseCase(IPlantRepository plantRepository) { 
            this.plantRepository = plantRepository;
        }

        public  List<Entities.Plant> Execute() {
            return plantRepository.GetAll();
        }
    }
}
