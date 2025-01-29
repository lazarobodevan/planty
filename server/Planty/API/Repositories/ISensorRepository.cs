using API.Database;
using API.Entities;

namespace API.Repositories {
    public interface ISensorRepository {

        Task AddPlantToSensor(Guid plantId);
        Task RemovePlantFromSensor(Guid plantId);
        List<Sensor> GetAvailableSensors();

        Task<bool> IsSensorAvailable(String sensorId);

    }
}
