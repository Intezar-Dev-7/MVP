import express from "express";
import { getMessages, markMessageSeen } from "../controllers/messageController.js";

const messageRouter = express.Router();

messageRouter.get("/:conversationId", getMessages);
messageRouter.patch("/seen", markMessageSeen);

export default messageRouter;