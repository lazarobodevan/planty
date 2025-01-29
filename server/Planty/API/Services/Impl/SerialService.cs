using API.Entities;
using API.Repositories;
using System.Globalization;
using System.IO.Ports;
using System.Text.RegularExpressions;
using System.Timers;

namespace API.Services.Impl
{
    public class SerialService : ISerialService
    {
        private readonly IServiceScopeFactory _serviceScopeFactory;
        private readonly SerialPort serialPort;
        private readonly System.Timers.Timer reconnectTimer;

        public int Lux { get; set; }
        public double Temperature { get; set; }
        public Dictionary<string, int> Moistures { get; set; }

        public SerialService(string portName, IServiceScopeFactory serviceScopeFactory)
        {
            serialPort = new SerialPort(portName, 9600);
            serialPort.DataReceived += async (sender, e) => await OnDataReceived(sender, e);
            _serviceScopeFactory = serviceScopeFactory;

            reconnectTimer = new System.Timers.Timer(500);
            reconnectTimer.Elapsed += async (sender, e) => await TryReconnect(sender, e);
            reconnectTimer.AutoReset = true;

            Lux = 0;
            Temperature = 0;
            Moistures = new Dictionary<string, int>();

            _ = InitializeAsync();
        }

        public async Task InitializeAsync()
        {
            await TryOpenPort();
            reconnectTimer.Start();
        }

        public bool IsPortOpen() {
            return serialPort.IsOpen;
        }

        public async Task TryOpenPort()
        {
            if (serialPort.IsOpen) return;

            try
            {
                serialPort.Open();
                Console.WriteLine($"Serial port {serialPort.PortName} opened successfully.");
                reconnectTimer.Stop(); // Para o timer ao conectar
                await SendConfig();
            }
            catch (IOException)
            {
                Console.WriteLine($"Serial port {serialPort.PortName} not available. Retrying...");
                reconnectTimer.Start(); // Inicia o timer de reconexão
            }
            catch (UnauthorizedAccessException)
            {
                Console.WriteLine($"Access to serial port {serialPort.PortName} denied. Retrying...");
                reconnectTimer.Start();
            }
        }

        public async Task TryReconnect(object? sender, ElapsedEventArgs? e)
        {
            if (!serialPort.IsOpen)
            {
                Console.WriteLine("Attempting to reconnect to serial port...");
                ClosePort(); // Garante que a porta está fechada antes de tentar reabrir
                await TryOpenPort();
            }
        }
        public void ClosePort()
        {
            try
            {
                if (serialPort.IsOpen)
                {
                    serialPort.Close();
                    Console.WriteLine($"Serial port {serialPort.PortName} closed.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to close serial port: {ex.Message}");
            }
        }

        public void StartReading()
        {
            try
            {
                if (!serialPort.IsOpen)
                {
                    serialPort.Open();
                }

                Console.WriteLine("Iniciando a leitura da porta serial...");
                /*
                while (serialPort.IsOpen) {
                    Console.WriteLine(serialPort.ReadLine());  // Exemplo de saída

                }
                */
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erro ao tentar ler a porta serial: {ex.Message}");
            }
        }

        public void SendMoistureData(Plant plant)
        {
            serialPort.WriteLine($"{plant.SensorPort}: {plant.IdealMoisturePercentage}");
            //Console.WriteLine(serialPort.ReadLine());
        }

        public async Task Start()
        {
            await TryOpenPort();
        }

        public async Task OnDataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            try
            {
                // Certifique-se de que há dados disponíveis antes de ler
                if (!serialPort.IsOpen || serialPort.BytesToRead == 0)
                {
                    return;
                }

                // Ler os dados da porta serial
                var data = serialPort.ReadExisting()?.Trim();

                if (string.IsNullOrEmpty(data))
                {
                    return;
                }

                //Console.WriteLine(data);

                // Verificar comandos específicos
                if (data.Equals("GET: config", StringComparison.OrdinalIgnoreCase))
                {
                    await SendConfig();
                }
                else
                {

                    var luxMatch = Regex.Match(data, @"Lux:\s*([\d\.]+)");
                    var tempMatch = Regex.Match(data, @"Temp:\s*([\d\.]+)");
                    var portMatches = Regex.Matches(data, @"A(\d+):\s*(-?\d+)");

                    if (luxMatch.Success && tempMatch.Success)
                    {

                        var culture = CultureInfo.InvariantCulture;

                        Lux = (int)double.Parse(luxMatch.Groups[1].Value, culture);
                        Temperature = double.Parse(tempMatch.Groups[1].Value, culture);
                    }

                    foreach (Match match in portMatches)
                    {
                        var portNumber = $"A{match.Groups[1].Value}"; // "A0"
                        var portValue = int.Parse(match.Groups[2].Value); // Valor da porta
                        Moistures[portNumber] = portValue >= 0 ? portValue : 0;
                    }
                }

            }
            catch (ArgumentOutOfRangeException ex)
            {
                Console.WriteLine($"Erro ao processar dados recebidos: {ex.Message}");
            }
            catch (IOException ex)
            {
                Console.WriteLine($"Erro de I/O na porta serial: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erro inesperado no OnDataReceived: {ex.Message}");
            }
        }


        public async Task SendConfig()
        {
            var sensorConfigs = GetSensorConfigs();
            await Task.Delay(2000);

            // Enviar dados no formato esperado
            foreach (var config in sensorConfigs)
            {
                serialPort.WriteLine(config);
                Console.WriteLine(config);
                await Task.Delay(1500);
            }

            // Enviar estado dos LEDs
            var ledState = GetLedStateFromDatabase();
            serialPort.WriteLine($"LED: {ledState}");
        }

        public void UpdateSensor(string sensorId, int value)
        {
            serialPort.WriteLine($"{sensorId} - moisture: {value}");
        }

        public List<string> GetSensorConfigs()
        {
            using var scope = _serviceScopeFactory.CreateScope();
            var plantRepository = scope.ServiceProvider.GetRequiredService<IPlantRepository>();

            Dictionary<string, int> sensorMap = new Dictionary<string, int> {
                {"A0", -1 },
                {"A3", -1 },
                {"A4", -1 },
                {"A5", -1 },
            };

            var plants = plantRepository.GetAll();

            List<string> messages = new List<string>();

            foreach (var plant in plants)
            {
                if (sensorMap.ContainsKey(plant.SensorPort))
                {
                    sensorMap[plant.SensorPort] = plant.IdealMoisturePercentage;
                }

            }

            foreach (var sensor in sensorMap)
            {
                messages.Add($"{sensor.Key} - moisture: {sensor.Value}");
            }
            return messages;
        }

        public string GetLedStateFromDatabase()
        {
            return "On";
        }
    }
}
