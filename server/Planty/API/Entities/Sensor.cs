using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace API.Entities {

    [Table(name:"sensors")]
    public class Sensor {

        [Key]
        [Column(name: "port")]
        public string Port { get; set; }

        public Plant Plant { get; set; }

        public List<PlantReading> PlantReading { get; set; }
    }
}
