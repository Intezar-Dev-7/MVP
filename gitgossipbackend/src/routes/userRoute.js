import express from "express";


import { fetchAllUsers, getUserDetails, updateUserDetails } from "../controllers/userController.js";
import verifyFirebaseToken from "../middlewares/verifyFirebaseToken.js";
import upload from "../middlewares/multer.js";

const userRouter = express.Router();


userRouter.patch("/updateUserDetails", verifyFirebaseToken, upload.single("profilePic"), updateUserDetails); //Uri.parse('$baseUrl/user/updateUserDetails'),
userRouter.get("/getUserDetails", verifyFirebaseToken, getUserDetails);
userRouter.get("/fetchAllUsers/:firebaseUid", fetchAllUsers);
export default userRouter;