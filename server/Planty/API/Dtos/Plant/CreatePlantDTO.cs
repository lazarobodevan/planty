using System.ComponentModel.DataAnnotations;

namespace API.Dtos.Plant {
    public class CreatePlantDTO {

        [Required]
        [MaxLength(100)]
        [MinLength(1)]
        public string Name { get; set; }

        [Required]
        [MaxLength(100)]
        public string Description { get; set; }

        [Required]
        [Range(0, 100, ErrorMessage = "O valor deve ser entre 0 e 100")]
        public int IdealMoisturePercentage { get; set; }

        [Required]
        [Range(0, 50000, ErrorMessage = "O valor deve ser entre 0 e 50000")]
        public int IdealLightExposure {  get; set; }

        [Required]
        [Range(0,45, ErrorMessage = "O valor deve ser entre 0 e 45")]
        public int IdealTemperatureCelsius { get; set;}

        [Required]
        public String SensorPort { get; set; }



    }
}
