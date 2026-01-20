

import newUser from "../models/userModel.js";
import cloudinary from "../config/cloudinary.js";

// PATCH /user/updateUserDetails
export const updateUserDetails = async (req, res) => {
    try {
        const firebaseUid = req.user.uid;

        const { fullName, username, userPhoneNumber, userBio, techStack, socialLinks } = req.body;

        const user = await newUser.findOne({ firebaseUid });
        if (!user) return res.status(404).json({ message: "User not found" });

        // ---------- USERNAME CHECK ----------
        if (username && username !== user.username) {
            const existingUser = await newUser.findOne({ username });
            if (existingUser) return res.status(409).json({ message: "Username already taken" });
            user.username = username;
        }

        // ---------- TEXT FIELDS ----------
        if (fullName) user.fullName = fullName;
        if (userPhoneNumber) user.userPhoneNumber = userPhoneNumber;
        if (userBio) user.userBio = userBio;
        if (techStack) user.techStack = JSON.parse(techStack);
        if (socialLinks) user.socialLinks = JSON.parse(socialLinks);

        // ---------- IMAGE UPLOAD ----------
        if (req.file) {
            // Delete old image
            if (user.profilePic) {
                const publicId = user.profilePic.split("/").pop().split(".")[0];
                await cloudinary.uploader.destroy(`profile_pics/${publicId}`);
            }

            // Upload new image
            const result = await new Promise((resolve, reject) => {
                const stream = cloudinary.uploader.upload_stream(
                    { folder: "profile_pics" },
                    (error, result) => {
                        if (error) reject(error);
                        else resolve(result);
                    }
                );
                stream.end(req.file.buffer);
            });

            user.profilePic = result.secure_url;
        }

        await user.save();

        return res.status(200).json({
            message: "Profile updated successfully",
            user,
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: "Something went wrong" });
    }
};

// GET /user/me
export const getUserDetails = async (req, res) => {
    try {
        const firebaseUid = req.user.uid;

        const user = await newUser.findOne({ firebaseUid });
        if (!user) return res.status(404).json({ success: false, message: "User not found" });

        return res.status(200).json({ success: true, data: user });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ success: false, message: "Server error" });
    }
};
