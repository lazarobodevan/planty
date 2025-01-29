using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace API.Entities {

    [Table(name:"plants")]
    public class Plant {

        public Plant() { }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [Column(name:"name")]
        public string Name { get; set; }

        [Column(name:"description")]
        public string Description { get; set; }

        [Column(name:"ideal_temperature_celsius")]
        [Required]
        public int IdealTemperatureCelsius { get; set; }

        [Required]
        [Column(name:"ideal_moisture_percentage")]
        public int IdealMoisturePercentage { get; set; }

        [Required]
        [Column(name:"ideal_light_exposure")]
        public int IdealLightExposure { get; set; }

        [Column(name:"sensor_port")]
        public string SensorPort { get; set; }

        [ForeignKey(nameof(SensorPort))]
        public Sensor Sensor { get; set; }

    }
}
