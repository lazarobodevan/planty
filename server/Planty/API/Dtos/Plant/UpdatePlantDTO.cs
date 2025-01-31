namespace API.Dtos.Plant {
    public class UpdatePlantDTO {

        public string? Name { get; set; }
        public string? Description { get; set; }
        public string? SensorPort { get; set; }
        public int? IdealMoisturePercentage { get; set; }
        public int? IdealLightExposure { get; set; }
        public int? IdealTemperatureCelsius { get; set; }

    }
}
