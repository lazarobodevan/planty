using API.Entities;

namespace API.Repositories {
    public interface IPlantReadingRepository {

        Task Create(PlantReading plantReading);

        List<PlantReading> GetBySensorId(string sensorId);
    }
}
