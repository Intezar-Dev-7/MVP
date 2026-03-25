import express from "express";
import { createOrGetConversation } from "../controllers/conversationController.js";

const conversationRouter = express.Router();

conversationRouter.post("/createConversation", createOrGetConversation);

export default conversationRouter;