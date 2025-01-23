"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.config = void 0;
exports.config = {
    websocket: {
        port: 8080,
    },
    serial: {
        path: '/dev/ttyUSB0',
        baudRate: 9600,
    },
};
