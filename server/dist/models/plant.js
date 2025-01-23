"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Plant {
    constructor(name, sensor, minMoisture, maxMoisture, minTemperature, maxTemperature) {
        this.name = name;
        this.sensor = sensor;
        this.minMoisture = minMoisture;
        this.maxMoisture = maxMoisture;
        this.minTemperature = minTemperature;
        this.maxTemperature = maxTemperature;
    }
}
exports.default = Plant;
