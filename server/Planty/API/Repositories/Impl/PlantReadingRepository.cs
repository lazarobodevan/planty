using API.Database;
using API.Entities;

namespace API.Repositories.Impl {
    public class PlantReadingRepository : IPlantReadingRepository{
        private readonly DatabaseContext databaseContext;

        public PlantReadingRepository(DatabaseContext databaseContext) {
            this.databaseContext = databaseContext;
        }

        public async Task Create(PlantReading plantReading) {
            await databaseContext.PlantsReadings.AddAsync(plantReading);
            await databaseContext.SaveChangesAsync();
        }

        public List<PlantReading> GetBySensorId(string sensorId) {

            var cutoffTime = DateTime.UtcNow.AddHours(-24);

            var readings = databaseContext.PlantsReadings
                .Where(s => s.SensorPort == sensorId && s.CreatedAt >= cutoffTime)
                .OrderBy(x => x.CreatedAt)
                .ToList();

            return readings;
        }
    }
}
