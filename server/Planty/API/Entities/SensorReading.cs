namespace API.Entities {
    public class SensorReading {

        public int Lux { get; set; }
        public double Temperature { get; set; }
        public Dictionary<string, int> Moistures { get; set; }

    }
}
