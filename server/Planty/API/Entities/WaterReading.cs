using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace API.Entities {

    [Table(name:"water_readings")]
    public class WaterReading {

        [Key]
        [Column(name: "id")]
        public Guid Id { get; set; }

        [Required]
        [Column(name: "moisture")]
        public int Moisture { get; set; }

        [Required]
        [Column(name: "created_at")]
        public DateTime CreatedAt { get; set; }
    }
}
