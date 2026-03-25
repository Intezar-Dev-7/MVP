
import express from "express";
import verifyFirebaseToken from "../middlewares/verifyFirebaseToken.js";
import { saveUser } from "../controllers/authController.js";


const authRouter = express.Router();

authRouter.post("/saveUser", verifyFirebaseToken, saveUser);

export default authRouter;
