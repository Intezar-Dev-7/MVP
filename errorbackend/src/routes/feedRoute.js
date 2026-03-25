import express from "express";
import verifyFirebaseToken from "../middlewares/verifyFirebaseToken.js";
import { fetchPostsForFeedScreen } from "../controllers/feedController.js";

const feedRouter = express.Router();

feedRouter.get("/fetchPostsForFeed", verifyFirebaseToken, fetchPostsForFeedScreen);

export default feedRouter;