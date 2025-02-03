namespace API.Dtos.PlantReading {
    public class PlantReadingsReponseDTO {

        public Guid PlantId { get; set; }
        public String PlantName { get; set; }
        public String PlantDescription { get; set; }
        public string SensorPort { get; set;}
        public int IdealMoisturePercentage { get; set; }
        public int IdealTemperatureCelsius { get; set; }
        public int IdealLightExposure { get; set; }
        public List<PlantReadingDTO> Readings { get; set; }

    }
}
