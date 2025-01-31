namespace API.Dtos.PlantReading {
    public class PlantReadingDTO {

        public Guid Id { get; set; }
        public int Moisture { get; set; }
        public int Light {  get; set; }
        public int TemperatureCelsius { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
