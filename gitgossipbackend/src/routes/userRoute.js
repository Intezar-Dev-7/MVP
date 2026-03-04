import express from "express";


import { getUserDetails, updateUserDetails } from "../controllers/userController.js";
import verifyFirebaseToken from "../middlewares/verifyFirebaseToken.js";
import upload from "../middlewares/multer.js"; 

const userRouter = express.Router();


userRouter.patch("/updateUserDetails", verifyFirebaseToken, upload.single("profilePic"), updateUserDetails); //Uri.parse('$baseUrl/user/updateUserDetails'),
userRouter.get("/getUserDetails", verifyFirebaseToken, getUserDetails);

export default userRouter;