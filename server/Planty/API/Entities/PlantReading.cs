using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace API.Entities {

    [Table(name:"plant_readings")]
    public class PlantReading {

        public PlantReading() { }

        [Key]
        [Column(name: "id")]
        public Guid Id { get; set; }

        [Required]
        [Column(name:"sensor_port")]
        public string SensorPort { get; set; }

        [ForeignKey(nameof(SensorPort))]
        public Sensor Sensor { get; set; }

        [Required]
        [Column(name: "plant_id")]
        public Guid PlantId { get; set; }

        [ForeignKey(nameof(PlantId))]
        public Plant Plant { get; set; }

        [Required]
        [Column(name:"moisture")]
        public int Moisture { get; set; }

        [Required]
        [Column(name: "light")]
        public int Light { get; set; }

        [Required]
        [Column(name:"temperature")]
        public int TemperatureCelsius { get; set; }

        [Required]
        [Column(name:"created_at")]
        public DateTime CreatedAt { get; set; }

    }
}
