
import express from "express";
import verifyFirebaseToken from "../middlewares/verifyFirebaseToken.js";
import { saveUser } from "../controllers/authController.js";


const authRouter = express.Router();

console.log("Auth Route hi");
authRouter.post("/saveUser", verifyFirebaseToken, saveUser);

export default authRouter;
