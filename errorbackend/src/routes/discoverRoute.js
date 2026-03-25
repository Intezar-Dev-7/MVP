import express from "express";
import verifyFirebaseToken from "../middlewares/verifyFirebaseToken.js";
import { fetchUserForDiscover } from "../controllers/discoverController.js";
const discoverRouter = express.Router();

discoverRouter.get("/fetchUsersForDiscoverScreen", verifyFirebaseToken, fetchUserForDiscover);

export default discoverRouter;