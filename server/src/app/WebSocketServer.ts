import { WebSocketServer as WSS, WebSocket } from 'ws';
import { IWebSocketServer } from '../interfaces/IWebSocketServer';
import { config } from '../config/config';
import { plant } from '../mockData/data';
import Logger from '../utils/Logger';
import SensorData from '../models/SensorData';

export default class WebSocketServer implements IWebSocketServer {
  private server: WSS;
  private clients: Set<WebSocket> = new Set();

  constructor() {
    this.server = new WSS({ port: config.websocket.port, host:'127.0.0.1' });
    this.server.on('connection', this.handleConnection.bind(this));
    Logger.info(`WebSocket Server iniciado na porta ${config.websocket.port}`);
  }

  public start() {
    Logger.info('WebSocket Server está ativo.');
  }

  public broadcast(message: string) {
    this.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        let sensorData = this.parseSensorData(message);
        let response = this.checkMoistureLevel(sensorData!);
        Logger.info(`Enviando mensagem para ${this.clients.size} clientes: ${message}`);
        client.send(JSON.stringify(response));
      }
    });
  }

  public handleConnection(ws: WebSocket) {
    Logger.info('Novo cliente conectado.');
    this.clients.add(ws);

    ws.on('close', () => {
      Logger.info('Cliente desconectado.');
      this.clients.delete(ws);
    });
  }

  private parseSensorData(data: string): SensorData | null {
    const regexLux = /Lux: (\d+\.\d+)/;
    const regexTemp = /Temp: (\d+\.\d+)/;
    const regexA0 = /A0: (\d+)/;

    const luxMatch = data.match(regexLux);
    const tempMatch = data.match(regexTemp);
    const a0Match = data.match(regexA0);

    if (luxMatch && tempMatch && a0Match) {
      return {
        lux: parseFloat(luxMatch[1]) ?? -2,
        temperature: parseFloat(tempMatch[1]) ?? -2,
        moisture: parseInt(a0Match[1], 10) ?? -2,
      } as SensorData;
    }
    return null;
  }

  private checkMoistureLevel(sensorData: SensorData) {
    // Carrega as configurações da planta do arquivo data.json
    const plantData = plant;

    // Verifica se a umidade está dentro da faixa
    const moisture = sensorData.moisture ?? -3;
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
