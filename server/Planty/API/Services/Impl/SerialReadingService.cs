using API.Entities;
using API.Repositories;

namespace API.Services.Impl
{
    public class SerialReadingService : IReadingsService {

        private readonly ISerialService serialService;
        private readonly IServiceScopeFactory _scopeFactory;

        public List<int> LuxReadings { get; set; }
        public List<double> TemperatureReadings { get; set; }
        public List<Dictionary<string, int>> MoistureReadings { get; set; }
        public System.Timers.Timer ReadTimer { get; set; }
        public System.Timers.Timer SaveTimer { get; set; }

        public SerialReadingService(ISerialService serialService, IServiceScopeFactory scopeFactory) { 

            this.LuxReadings = new List<int>();
            this.TemperatureReadings = new List<double>();
            this.MoistureReadings = new List<Dictionary<string, int>>();
            this.serialService = serialService;
            _scopeFactory = scopeFactory;

            this.ReadTimer = new System.Timers.Timer(5 * 60 * 1000); // 5 min em ms
            this.ReadTimer.Elapsed += (sender, args) => ReadData();

            this.SaveTimer = new System.Timers.Timer(60 * 60 * 1000); //1h em ms
            this.SaveTimer.Elapsed += async (sender, args) => await SaveData();
        }

        public void ReadData() {
            Console.WriteLine( "Lendo......");
            try {
                if (!serialService.IsPortOpen()) throw new Exception("Porta fechada");

                LuxReadings.Add(serialService.Lux);
                TemperatureReadings.Add(serialService.Temperature);
                MoistureReadings.Add(serialService.Moistures);

            }catch(Exception ex) {
                throw new Exception($"Falha ao ler dados: {ex.Message}");
            }
        }

        public async Task SaveData() {
            using var scope = _scopeFactory.CreateScope();
            var plantRepository = scope.ServiceProvider.GetRequiredService<IPlantRepository>();
            var sensorReadingRepository = scope.ServiceProvider.GetRequiredService<IPlantReadingRepository>();

            var plants = plantRepository.GetAll();

            foreach (var plant in plants) {

                var plantMoistureReadings = MoistureReadings
                    .SelectMany(dict => dict) 
                    .Where(pair => pair.Key == plant.SensorPort) 
                    .Select(pair => pair.Value) 
                    .ToList();

                // Calcula a média, se houver leituras
                int averageMoisture = plantMoistureReadings.Any()
                    ? Convert.ToInt32(plantMoistureReadings.Average())
                    : 0;

                var plantReadingEntity = new PlantReading {
                    Id = Guid.NewGuid(),
                    PlantId = plant.Id,
                    SensorPort = plant.SensorPort,
                    Light = Convert.ToInt32(LuxReadings.Average()),
                    TemperatureCelsius = Convert.ToInt32(TemperatureReadings.Average()),
                    Moisture = averageMoisture,
                    CreatedAt = DateTime.UtcNow,
                };

                await sensorReadingRepository.Create(plantReadingEntity);
                
            }

            this.TemperatureReadings = [];
            this.MoistureReadings = [];
            this.LuxReadings = [];
        }

        public void StartTimers() {
            ReadTimer.Start();
            SaveTimer.Start();
        }

        public void StopTimers() {
            ReadTimer.Stop();
            SaveTimer.Stop();
        }
    }
}
