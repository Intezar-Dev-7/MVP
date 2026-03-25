import Post from "../models/postModel.js";



export const fetchPostsForFeedScreen = async (req, res) => {
    console.log("📢 Fetch Feed Posts");

    try {
        const posts = await Post.find()
            .sort({ createdAt: -1 }); // newest first

        /// 🔥 Format response (clean for frontend)
        const formattedPosts = posts.map((post) => ({
            id: post._id,

            /// 👤 User Info
            firebaseUid: post.firebaseUid,
            username: post.username,
            userProfilePic: post.userProfilePic,

            /// 📝 Post Content
            title: post.title,
            description: post.postDescription,
            images: post.postImages,

            /// 🔗 Links
            githubUrl: post.githubUrl,
            liveDemoUrl: post.liveDemoUrl,

            /// 📊 Engagement
            likes: post.likes,
            comments: post.comments,
            shares: post.shares,

            /// ⏱️ Time
            createdAt: post.createdAt,
        }));

        res.status(200).json(formattedPosts);
    } catch (error) {
        console.error("❌ Feed Error:", error);
        res.status(500).json({ message: "Server error" });
    }
}