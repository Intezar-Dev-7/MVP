/*
app.js is responsible for defining the routes, middleware, and other application-level functionality. */



import express from "express";

import dotenv from 'dotenv';
import { ConnectDB } from "./config/db.js";
import authRouter from "./routes/authRoute.js";
import postRouter from "./routes/postRoute.js";
import userRouter from "./routes/userRoute.js";
import messageRouter from "./routes/messageRoute.js";
import conversationRouter from "./routes/conversationRoute.js";
import discoveRouter from "./routes/discoverRoute.js";
import feedRouter from "./routes/feedRoute.js";

dotenv.config();
const app = express();

// PARSE JSON REQUESTS 
app.use(express.json());

// MongoDB connection 
ConnectDB();

app.get('/health', (req, res) => {
    res.send('Backend Is Running');
});

app.use("/posts", postRouter);
app.use("/auth", authRouter);
app.use("/user", userRouter);
app.use("/conversation", conversationRouter);
app.use("/message", messageRouter);
app.use("/discover", discoveRouter);
app.use("/feed", feedRouter);


export default app;