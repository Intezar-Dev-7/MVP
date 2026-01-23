
import newUser from "../models/userModel.js";

export const saveUser = async (req, res) => {
    console.log("🔥 SAVE USER CONTROLLER HIT");

    try {
        console.log("I am here 1");
        console.log("req.user:", req.user);
        const { uid, fullName, email, profilePic } = req.user;

        if (!uid) {
            return res.status(401).json({ message: "Invalid Firebase token" });
        }

        const user = await newUser.findOneAndUpdate(
            { firebaseUid: req.user.uid },
            {
                // LEFT → MongoDB schema field name
                // RIGHT → Runtime value coming from your app / Firebase / request
                $setOnInsert: {
                    firebaseUid: req.user.uid,
                    email: req.user.email,
                    fullName: req.user.name,
                    profilePic: req.user.profilePic,
                    provider: req.user.provider,
                    createdAt: new Date(),
                },
            },
            { upsert: true, new: true }
        );

        // const user = await newUser.findOneAndUpdate(
        //     { firebaseUid: uid },
        //     {
        //         $setOnInsert: {
        //             firebaseUid: uid,
        //             email: email || null,        // initial sync
        //             name: name || null,          // initial default ONLY
        //             profilePic: picture || null, // initial default ONLY
        //          
        //             createdAt: new Date(),
        //         },
        //         $set: {
        //             // only fields Firebase truly owns
        //             ...(email && { email }),
        //             updatedAt: new Date(),
        //         },
        //     },
        //     { upsert: true, new: true }
        // );

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
