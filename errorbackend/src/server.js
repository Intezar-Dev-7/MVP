
/* server.js, on the other hand, is responsible for creating the server, listening for incoming requests, and handling errors.*/

import dotenv from 'dotenv';
dotenv.config();
import http from "http";

import app from './app.js';
import { Server } from "socket.io";
import { initSocket } from './services/socketService.js';

const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    }
});

// Initialize socket logic 
initSocket(io);


server.listen(process.env.PORT, '0.0.0.0', () => {
    console.log('Server Started on port', process.env.PORT);
});