/* server.js, on the other hand, is responsible for creating the server, listening for incoming requests, and handling errors.*/

import dotenv from 'dotenv';
dotenv.config();
import app from './app.js';



app.listen(process.env.PORT || 5000, '0.0.0.0', () => {
    console.log('Server Started on port', process.env.PORT || 5000);
});