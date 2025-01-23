import WebSocketServer from './app/WebSocketServer';
import SerialService from './app/SerialService';
import Logger from './utils/Logger';

const webSocketServer = new WebSocketServer();

new SerialService((data: string) => {
  webSocketServer.broadcast(data);
});

webSocketServer.start();

Logger.info('Servidor iniciado com sucesso!');
