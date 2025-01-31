using API.Entities;
using API.Repositories;
using Microsoft.Extensions.DependencyInjection;
using System.Globalization;
using System.IO.Ports;
using System.Text.RegularExpressions;
using System.Timers;

namespace API.Services {
    public interface ISerialService {
        int Lux { get; set; }
        double Temperature { get; set; }
        Dictionary<string, int> Moistures { get; set; }

        Task InitializeAsync();

        Task TryOpenPort();

        bool IsPortOpen();

        Task TryReconnect(object? sender, ElapsedEventArgs? e);
        void ClosePort();

        void StartReading();

        void SendMoistureData(Plant plant);

        Task Start();

        Task OnDataReceived(object sender, SerialDataReceivedEventArgs e);


        Task SendConfig();

        void UpdateSensor(string sensorId, int value);

        List<string> GetSensorConfigs();

        string GetLedState();

        void ToggleLED();
    }

}
