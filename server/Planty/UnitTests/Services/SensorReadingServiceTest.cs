using API.Entities;
using API.Repositories;
using API.Services;
using API.Services.Impl;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnitTests.Services {
    public class SensorReadingServiceTest {

        private Mock<IPlantReadingRepository> _sensorReadingRepository;
        private Mock<IPlantRepository> _plantRepository;
        private Mock<ISerialService> _serialService;
        private Mock<IServiceScope> _scope;
        private Mock<IServiceProvider> _provider;
        private Mock<IServiceScopeFactory> _factory;

        public SensorReadingServiceTest() {
            _plantRepository = new Mock<IPlantRepository>();
            _sensorReadingRepository = new Mock<IPlantReadingRepository>();
            _serialService = new Mock<ISerialService>();
            _factory = new Mock<IServiceScopeFactory>();
            _scope = new Mock<IServiceScope>();
            _provider = new Mock<IServiceProvider>();
        }

        [Fact]
        public async Task Save_WhenSaveDataMethodIsCalled_ReturnsVoid() {

            //Arrange
            List<Dictionary<string, int>> moistures = new List<Dictionary<string, int>> {
                new Dictionary<string, int> {
                    {"A0", 10 },
                    {"A5", 20 }
                },
                new Dictionary<string, int> {
                    {"A0", 10 },
                    {"A5", 20 }
                }
            };

            List<double> temperatures = new List<double> { 30, 30, 30, 30};
            List<int> lux = new List<int> { 500, 500, 500, 500, };

            List<Plant> plants = new List<Plant> {
                new Plant {
                    Id = Guid.NewGuid(),
                    Name = "Test",
                    Description = "Test",
                    IdealLightExposure = 2000,
                    IdealMoisturePercentage = 80,
                    IdealTemperatureCelsius = 26,
                    SensorPort = "A0"
                },
                new Plant {
                    Id = Guid.NewGuid(),
                    Name = "Test 2",
                    Description = "Test 2",
                    IdealLightExposure = 500,
                    IdealMoisturePercentage = 50,
                    IdealTemperatureCelsius = 29,
                    SensorPort = "A5"
                }
            };

            var capturedReadings = new List<PlantReading>();

            _scope.Setup(s => s.ServiceProvider).Returns(_provider.Object);
            _factory.Setup(f => f.CreateScope()).Returns(_scope.Object);

            _provider.Setup(x => x.GetService(typeof(IPlantRepository))).Returns(_plantRepository.Object);
            _provider.Setup(x => x.GetService(typeof(IPlantReadingRepository))).Returns(_sensorReadingRepository.Object);

            _plantRepository.Setup(x => x.GetAll()).Returns(plants);
            _sensorReadingRepository.Setup(x => x.Create(
                It.IsAny<PlantReading>()))
                .Returns(Task.CompletedTask)
                .Callback<PlantReading>(reading => capturedReadings.Add(reading));


            IReadingsService serialReadingService = new SerialReadingService(
                _serialService.Object,
                _factory.Object

                );
            serialReadingService.MoistureReadings = moistures;
            serialReadingService.LuxReadings = lux;
            serialReadingService.TemperatureReadings = temperatures;

            //Act

            await serialReadingService.SaveData();

            //Assert

            _sensorReadingRepository.Verify(x => x.Create(It.IsAny<PlantReading>()), Times.Exactly(plants.Count));

            Assert.Equal(plants.Count, capturedReadings.Count);

            foreach (var plant in plants) {
                var expectedMoisture = plant.SensorPort == "A0" ? 10 : 20;
                var reading = capturedReadings.FirstOrDefault(r => r.Moisture == expectedMoisture);

                Assert.NotNull(reading);
                Assert.Equal(500, reading.Light); 
                Assert.Equal(30, reading.TemperatureCelsius); 
                Assert.Equal(expectedMoisture, reading.Moisture); 
                Assert.True(reading.CreatedAt <= DateTime.Now); 
            }



        }

    }
}
