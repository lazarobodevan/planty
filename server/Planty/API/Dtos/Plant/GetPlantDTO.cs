namespace API.Dtos.Plant {
    public class GetPlantDTO {

        public Guid Id { get; set; }

        public string Name { get; set; }
        public string Description { get; set; }

        public int IdealMoisturePercentage { get; set; }
        public int CurrentMoisturePercentage { get; set; }

        public int IdealLightExposure {  get; set; }
        public int CurrentLightExposure { get; set;}

        public double IdealTemperatureCelsius { get; set; }
        public double CurrentTemperatureCelsius { get; set; }

        public string SensorPort { get; set; }


    }
}
