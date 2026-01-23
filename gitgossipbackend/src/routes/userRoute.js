import verifyFirebaseToken from "../middlewares/verifyFirebaseToken";


const userRouter = express.Router();

userRouter.patch("/updateUser", verifyFirebaseToken, updateUser);
userRouter.patch("/getUserDetails", verifyFirebaseToken, getUserDetails);