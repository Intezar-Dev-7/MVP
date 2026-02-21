import express from "express";


import { getUserDetails, updateUserDetails } from "../controllers/userController.js";
import verifyFirebaseToken from "../middlewares/verifyFirebaseToken.js";


const userRouter = express.Router();

userRouter.patch("/updateUser", verifyFirebaseToken, updateUserDetails);
userRouter.get("/getUserDetails", verifyFirebaseToken, getUserDetails);

export default userRouter;