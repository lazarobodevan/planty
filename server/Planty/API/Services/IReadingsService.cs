using API.Entities;
using System.Timers;

namespace API.Services {
    public interface IReadingsService {

        List<int> LuxReadings { get; set; }
        List<double> TemperatureReadings { get; set; }
        List<Dictionary<string, int>> MoistureReadings { get; set; }

        System.Timers.Timer ReadTimer { get; set; }
        System.Timers.Timer SaveTimer { get; set; }


        void ReadData();

        Task SaveData();

        void StartTimers();
        void StopTimers();

    }
}
