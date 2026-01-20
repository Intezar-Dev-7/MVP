

import newPost from "../models/postModel.js";
import cloudinary from "../config/cloudinary.js";
import newUser from "../models/userModel.js";

export const createPost = async (req, res) => {
    try {
        const { postDescription, githubUrl, liveDemoUrl } = req.body;

        const authorUid = req.user.uid;
        console.log("Firebase UID:", authorUid);
        // 7VUzAPnQwRdApghpWQ6gp0EvXWB2


        // 🔥 FETCH USER FROM DB
        const user = await newUser.findOne({ firebaseUid: authorUid });

        console.log("User from DB:", user); // ✅ NOW VALID

        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        const userProfileImage = req.user.profileImage || null;

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

        const post = await newPost.create({
            authorUid,
            name: user.name, // ✅ NOW DEFINED
            userProfileImage,
            caption: postDescription,
            imageUrls: uploadedImages,
            githubUrl,
            liveDemoUrl,
            tags: [],
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
        const userUid = req.user.uid; // from Firebase middleware

        const posts = await newPost.find({ authorUid: userUid })
            .sort({ createdAt: -1 });

        res.status(200).json(posts);
    } catch (error) {
        console.error("Error fetching user posts:", error);
        res.status(500).json({
            message: "Failed to fetch user posts",
        });
    }
};
