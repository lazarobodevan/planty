"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const serialport_1 = require("serialport");
const parser_readline_1 = require("@serialport/parser-readline");
class SerialService {
    constructor(onDataCallback) {
        this.onDataCallback = onDataCallback;
        this.buffer = '';
        // Defina as configurações de conexão (porta, baudRate, etc.)
        const portOptions = {
            path: 'COM4', // Nome da porta, por exemplo '/dev/ttyUSB0' no Linux ou 'COM1' no Windows
            baudRate: 9600, // Taxa de transmissão (baud rate)
            dataBits: 8, // Número de bits de dados
            stopBits: 1, // Número de bits de parada
            parity: 'none', // Paridade: "none", "even", "odd"
        };
        // Inicializa o SerialPort com as opções adequadas
        this.serialPort = new serialport_1.SerialPort(portOptions);
        // Define o parser para ler as linhas (novas linhas '\n' delimitam os dados)
        const parser = this.serialPort.pipe(new parser_readline_1.ReadlineParser({ delimiter: '\n' }));
        parser.on('data', this.onData.bind(this));
    }
    onData(data) {
        //console.log(`Dados recebidos do Arduino: ${data}`);
        this.buffer += data.trim() + '\n';
        if (this.buffer.includes('--')) {
            this.onDataCallback(this.buffer);
            this.buffer = '';
        }
    }
}
exports.default = SerialService;
