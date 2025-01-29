using API.Database;
using API.Entities;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories.Impl {
    public class SensorRepository : ISensorRepository {

        private readonly DatabaseContext databaseContext;
        public SensorRepository(DatabaseContext databaseContext) {
            this.databaseContext = databaseContext;
        }

        public Task AddPlantToSensor(Guid plantId) {
            throw new NotImplementedException();
        }

        public List<Sensor> GetAvailableSensors() {
            return databaseContext.Sensors.Where(s => s.Plant == null).ToList();
        }

        public async Task<bool> IsSensorAvailable(string port) {
            var sensor = await databaseContext.Sensors.Where(item => item.Port == port).Include(item => item.Plant).FirstAsync();

            if(sensor.Plant == null) {
                return true;
            }
            return false;
        }

        public Task RemovePlantFromSensor(Guid plantId) {
            throw new NotImplementedException();
        }
    }
}
