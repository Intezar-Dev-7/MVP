

import express from "express";
import upload from "../middlewares/multer.js";
import verifyFirebaseToken from "../middlewares/verifyFirebaseToken.js";
import { createPost, getUserPosts } from "../controllers/postController.js";

const postRouter = express.Router();

postRouter.post(
    "/posts/createNewPost",
    verifyFirebaseToken,
    upload.array("images", 5), // MAX 5 images
    createPost
);


postRouter.get(
    "/posts/getUserPosts",
    verifyFirebaseToken, getUserPosts
);

export default postRouter;
