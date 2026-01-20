/*
app.js is responsible for defining the routes, middleware, and other application-level functionality. */



import express from "express";

import dotenv from 'dotenv';
import { ConnectDB } from "./config/db.js";
import authRouter from "./routes/authRoute.js";
import postRouter from "./routes/postRoute.js";
// import userRouter from "./routes/userRoute.js";

dotenv.config();
const app = express();

// PARSE JSON REQUESTS 
app.use(express.json());

// MongoDB connection 
ConnectDB();

app.get('/health', (req, res) => {
    res.send('GitGossip Auth Backend Is Running');
});

app.use(postRouter);
app.use(authRouter);
// app.use(userRouter);


export default app;