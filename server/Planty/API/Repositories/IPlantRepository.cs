using API.Entities;

namespace API.Repositories {
    public interface IPlantRepository {

        Task<Plant> Create(Plant plant);
        Task<Plant> Update(Plant plant);
        Task<Plant> Delete(Guid Id);
        Task<Plant> GetById(Guid Id);
        List<Plant> GetAll();

    }
}
