namespace API.Dtos.PlantReading {
    public class PlantReadingsReponseDTO {

        public Guid PlantId { get; set; }
        public string SensorPort { get; set;}
        public List<PlantReadingDTO> Readings { get; set; }

    }
}
