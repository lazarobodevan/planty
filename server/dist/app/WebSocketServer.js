"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const ws_1 = require("ws");
const config_1 = require("../config/config");
const data_1 = require("../mockData/data");
const Logger_1 = __importDefault(require("../utils/Logger"));
class WebSocketServer {
    constructor() {
        this.clients = new Set();
        this.server = new ws_1.WebSocketServer({ port: config_1.config.websocket.port, host: '127.0.0.1' });
        this.server.on('connection', this.handleConnection.bind(this));
        Logger_1.default.info(`WebSocket Server iniciado na porta ${config_1.config.websocket.port}`);
    }
    start() {
        Logger_1.default.info('WebSocket Server está ativo.');
    }
    broadcast(message) {
        this.clients.forEach((client) => {
            if (client.readyState === ws_1.WebSocket.OPEN) {
                let sensorData = this.parseSensorData(message);
                let response = this.checkMoistureLevel(sensorData);
                Logger_1.default.info(`Enviando mensagem para ${this.clients.size} clientes: ${message}`);
                client.send(JSON.stringify(response));
            }
        });
    }
    handleConnection(ws) {
        Logger_1.default.info('Novo cliente conectado.');
        this.clients.add(ws);
        ws.on('close', () => {
            Logger_1.default.info('Cliente desconectado.');
            this.clients.delete(ws);
        });
    }
    parseSensorData(data) {
        var _a, _b, _c;
        const regexLux = /Lux: (\d+\.\d+)/;
        const regexTemp = /Temp: (\d+\.\d+)/;
        const regexA0 = /A0: (\d+)/;
        const luxMatch = data.match(regexLux);
        const tempMatch = data.match(regexTemp);
        const a0Match = data.match(regexA0);
        if (luxMatch && tempMatch && a0Match) {
            return {
                lux: (_a = parseFloat(luxMatch[1])) !== null && _a !== void 0 ? _a : -2,
                temperature: (_b = parseFloat(tempMatch[1])) !== null && _b !== void 0 ? _b : -2,
                moisture: (_c = parseInt(a0Match[1], 10)) !== null && _c !== void 0 ? _c : -2,
            };
        }
        return null;
    }
    checkMoistureLevel(sensorData) {
        var _a;
        // Carrega as configurações da planta do arquivo data.json
        const plantData = data_1.plant;
        // Verifica se a umidade está dentro da faixa
        const moisture = (_a = sensorData.moisture) !== null && _a !== void 0 ? _a : -3;
        const moistureInRange = moisture >= plantData.minMoisture && moisture <= plantData.maxMoisture;
        // Cria o objeto com as leituras atuais e o estado da planta
        const response = {
            name: plantData.name,
            lux: sensorData.lux,
            temp: sensorData.temperature,
            moisture: sensorData.moisture,
            moistureInRange,
            plantData,
        };
        return response;
    }
}
exports.default = WebSocketServer;
