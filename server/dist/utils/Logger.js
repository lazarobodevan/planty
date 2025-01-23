"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Logger {
    static info(message) {
        console.log(`[INFO] ${new Date().toISOString()} - ${message}`);
    }
    static error(message) {
        console.error(`[ERROR] ${new Date().toISOString()} - ${message}`);
    }
}
exports.default = Logger;
