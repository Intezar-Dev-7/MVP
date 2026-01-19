import verifyFirebaseToken from "../middlewares/verifyFirebaseToken";


const userRoute = express.Router();

userRoute.patch("/user/updateUser", verifyFirebaseToken, updateUser);