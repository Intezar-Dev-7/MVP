import verifyFirebaseToken from "../middlewares/verifyFirebaseToken";


const userRouter = express.Router();

userRouter.patch("/user/updateUser", verifyFirebaseToken, updateUser);
userRouter.patch("/user/getUserDetails", verifyFirebaseToken, getUserDetails);