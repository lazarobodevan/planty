namespace API.Dtos.Readings {
    public class CurrentReadingsDTO {

        public int Lux {  get; set; }
        public double Temperature { get; set; }
        public int? Moisture { get; set; }
    }
}
