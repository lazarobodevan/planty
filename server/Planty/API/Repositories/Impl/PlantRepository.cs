using API.Database;
using API.Entities;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories.Impl {
    public class PlantRepository : IPlantRepository {

        private readonly DatabaseContext databaseContext;

        public PlantRepository(DatabaseContext databaseContext) {
            this.databaseContext = databaseContext;
        }

        public async Task<Plant> Create(Plant plant) {
            
            var createdPlant = await databaseContext.Plants.AddAsync(plant);
            await databaseContext.SaveChangesAsync();

            createdPlant.Entity.Sensor = null;
            return createdPlant.Entity;
        }

        public async Task<Plant> Delete(Guid Id) {
            var deletedPlant = await databaseContext.Plants.Where(item => item.Id == Id).FirstAsync();
            databaseContext.Plants.Remove(deletedPlant);
            await databaseContext.SaveChangesAsync();

            return deletedPlant;
        }

        public async Task<Plant?> GetById(Guid Id) {
            return await databaseContext.Plants.Where(item => item.Id == Id).AsNoTracking().FirstOrDefaultAsync();
        }

        public List<Plant> GetAll() {
            return databaseContext.Plants.ToList();
        }

        public async Task<Plant> Update(Plant plant) {
            var updatedPlant = databaseContext.Plants.Update(plant);
            await databaseContext.SaveChangesAsync();
            return updatedPlant.Entity;
        }
    }
}
