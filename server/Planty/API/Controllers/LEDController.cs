using API.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class LEDController : ControllerBase {

        private readonly ISerialService serialService;

        public LEDController(ISerialService serialService) {
            this.serialService = serialService;
        }

        [HttpPost("toggle")]
        public IActionResult ToggleLED() {
            try {
                serialService.ToggleLED();

                return Ok();
            }catch(Exception ex) {
                return new BadRequestObjectResult(new { erro = ex.Message});
            }
        }

        [HttpGet("fetch")]
        public IActionResult GetLEDStatus() {
            try {
                return Ok(new { status = serialService.GetLedState() });
            }catch(Exception ex) {
                return new BadRequestObjectResult(new { erro = ex.Message });
            }
        }
    }
}
