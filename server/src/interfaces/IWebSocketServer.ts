import { WebSocket } from 'ws';

export interface IWebSocketServer {
  start(): void;
  broadcast(message: string): void;
  handleConnection(ws: WebSocket): void;
}