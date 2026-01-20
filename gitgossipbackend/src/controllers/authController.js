
import newUser from "../models/userModel.js";
export const saveUser = async (req, res) => {
    try {
        console.log("I am here 1");
        const { uid, name, email, picture } = req.user;

        if (!uid) {
            return res.status(401).json({ message: "Invalid Firebase token" });
        }

        const user = await newUser.findOneAndUpdate(
            { firebaseUid: uid },
            {
                $setOnInsert: {
                    firebaseUid: uid,
                    email: email || null,        // initial sync
                    name: name || null,          // initial default ONLY
                    profilePic: picture || null, // initial default ONLY
                    role: "user",
                    createdAt: new Date(),
                },
                $set: {
                    // only fields Firebase truly owns
                    ...(email && { email }),
                    updatedAt: new Date(),
                },
            },
            { upsert: true, new: true }
        );

        console.log("reached here ");
        return res.status(200).json({
            success: true,
            user: {
                id: user._id,
                name: user.name,
                email: user.email,
                profilePic: user.profilePic,
            },
        });
    } catch (error) {
        console.error("MongoDB Save Error:", error);
        return res.status(500).json({ message: "Server error" });
    }
};
