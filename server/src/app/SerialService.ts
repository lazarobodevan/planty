import { SerialPort, SerialPortOpenOptions } from 'serialport';
import { ReadlineParser } from '@serialport/parser-readline';

export default class SerialService {
  private serialPort: SerialPort;
  private buffer: string = '';

  constructor(private onDataCallback: (data: string) => void) {

    // Defina as configurações de conexão (porta, baudRate, etc.)
    const portOptions: SerialPortOpenOptions<any> = {
      path: 'COM4',  // Nome da porta, por exemplo '/dev/ttyUSB0' no Linux ou 'COM1' no Windows
      baudRate: 9600,        // Taxa de transmissão (baud rate)
      dataBits: 8,           // Número de bits de dados
      stopBits: 1,           // Número de bits de parada
      parity: 'none',        // Paridade: "none", "even", "odd"
    };

    // Inicializa o SerialPort com as opções adequadas
    this.serialPort = new SerialPort(portOptions);

    // Define o parser para ler as linhas (novas linhas '\n' delimitam os dados)
    const parser = this.serialPort.pipe(new ReadlineParser({ delimiter: '\n' }));
    parser.on('data', this.onData.bind(this));
  }

  private onData(data: string) {
    //console.log(`Dados recebidos do Arduino: ${data}`);
    this.buffer += data.trim() + '\n';

    if(this.buffer.includes('--')){
        this.onDataCallback(this.buffer);
        this.buffer = '';
    }
  }
}
