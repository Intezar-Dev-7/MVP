
import User from "../models/userModel.js";


export const saveUser = async (req, res) => {
    console.log("🔥 SAVE USER CONTROLLER HIT");
    console.log("REQ.USER:", req.user);

    try {
        const { firebaseUid, email, fullName, profilePic } = req.user;

        if (!firebaseUid) {
            return res.status(401).json({ message: "Invalid Firebase token" });
        }
        const user = await User.findOneAndUpdate(
            { firebaseUid: firebaseUid },
            {
                $setOnInsert: {
                    firebaseUid,
                    email,
                    fullName,
                    profilePic,
                },
            },
            { upsert: true, new: true }
        );

        console.log("✅ USER SAVED OR FOUND:", user._id);

        return res.status(200).json({
            success: true,
            user,
        });
    } catch (error) {
        console.error("❌ MongoDB Save Error:", error);
        return res.status(500).json({ message: "Server error" });
    }
};
