import User from "../models/userModel.js";

export const fetchUserForDiscover = async (req, res) => {
    console.log("Fetch Users For Discover Screen");

    try {
        const firebaseUid = req.user.firebaseUid; // or req.query

        const users = await User.find(
            { firebaseUid: { $ne: firebaseUid } },
            "fullName username userBio profilePic techStack"
        );
        console.log(users);
        res.status(200).json(users);

    } catch (error) {

        console.log(error);
        return res.status(500).json({ message: "Server error" });
    }
};