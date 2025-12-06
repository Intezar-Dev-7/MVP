
import express from "express";
import verifyFirebaseToken from "../middlewares/verifyFirebaseToken.js";
import newUser from "../models/userModel.js"; // Correct import

const authRouter = express.Router();

// -------------------------------------------------
// Store or update user in MongoDB
// -------------------------------------------------
authRouter.post("/auth/saveUser", verifyFirebaseToken, async (req, res) => {
    try {
        const { uid, name, email, picture } = req.user;

        console.log("Saving user to MongoDB:", req.user); // Debug log

        // Upsert: create new or update existing user
        const user = await newUser.findOneAndUpdate(
            { firebaseUid: uid },
            {
                name: name || "Unknown",
                email: email || "Unknown",
                profilePic: picture || "",
            },
            { upsert: true, new: true }
        );

        return res.json({ success: true, user });
        console.log("User data successfully stored to mongo db ");
    } catch (error) {
        console.error("MongoDB Save Error:", error);
        return res.status(500).json({ message: "Server error" });
    }
});

export default authRouter;
