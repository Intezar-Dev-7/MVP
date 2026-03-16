


import cloudinary from "../config/cloudinary.js";
import User from "../models/userModel.js";
import Post from "../models/postModel.js";

export const createPost = async (req, res) => {
    try {
        const { title, postDescription, githubUrl, liveDemoUrl } = req.body;

        const firebaseUid = req.user.firebaseUid;
        console.log("Firebase UID:", firebaseUid);
        // 7VUzAPnQwRdApghpWQ6gp0EvXWB2


        // 🔥 FETCH USER FROM DB
        const user = await User.findOne({ firebaseUid: firebaseUid });

        console.log("User from DB:", user); // ✅ NOW VALID

        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }



        let uploadedImages = [];

        if (req.files && req.files.length > 0) {
            for (const file of req.files) {
                const imageUrl = await new Promise((resolve, reject) => {
                    cloudinary.uploader.upload_stream(
                        { folder: "posts" },
                        (error, result) => {
                            if (error) return reject(error);
                            resolve(result.secure_url);
                        }
                    ).end(file.buffer);
                });

                uploadedImages.push(imageUrl);
            }
        }

        const post = await Post.create({
            firebaseUid,
            username: user.username,
            userProfilePic: user.profilePic,
            title: title,
            postDescription: postDescription,
            postImages: uploadedImages,
            githubUrl,
            liveDemoUrl,

        });
        console.log("1");
        return res.status(201).json({
            success: true,
            message: "Post created successfully",
            post,
        });

    } catch (error) {
        console.error("Error creating post:", error);
        return res.status(500).json({
            success: false,
            message: "Internal Server Error",
        });
    }



};



export const getUserPosts = async (req, res) => {
    try {
        const firebaseUid = req.user.firebaseUid;

        const posts = await Post.find({ firebaseUid: firebaseUid })
            .sort({ createdAt: -1 });

        res.status(200).json(posts);
    } catch (error) {
        console.error("Error fetching user posts:", error);
        res.status(500).json({
            message: "Failed to fetch user posts",
        });
    }
};
