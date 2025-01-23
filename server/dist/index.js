"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const WebSocketServer_1 = __importDefault(require("./app/WebSocketServer"));
const SerialService_1 = __importDefault(require("./app/SerialService"));
const Logger_1 = __importDefault(require("./utils/Logger"));
const webSocketServer = new WebSocketServer_1.default();
new SerialService_1.default((data) => {
    webSocketServer.broadcast(data);
});
webSocketServer.start();
Logger_1.default.info('Servidor iniciado com sucesso!');
