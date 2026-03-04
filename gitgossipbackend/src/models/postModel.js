import mongoose from "mongoose";

/**
 * Post Schema
 * -----------
 * Represents a user-created post/project.
 */
const newPostSchema = new mongoose.Schema(
    {
        /**
         * Firebase UID of the author
         */
        firebaseUid: {
            type: String,
            required: true,
            index: true,
        },

        /**
         * Author display name (denormalized for performance)
         */
        username: {
            type: String,
            required: true,
        },

        /**
         * Author profile image URL
         */
        userProfilePic: {
            type: String,
            default: null,
        },

        /**
         * Post title
         */
        title: {
            type: String,
            required: true,
            trim: true,
        },

        /**
         * Post description / caption
         */
        postDescription: {
            type: String,
            default: "",
            trim: true,
        },

        /**
         * Optional image attached to the post
         */
        postImages: [
            {
                type: String,
                
            }
        ],

        /**
         * Optional GitHub repository link
         */
        githubUrl: {
            type: String,
            default: null,
        },

        /**
         * Optional live demo link
         */
        liveDemoUrl: {
            type: String,
            default: null,
        },

        /**
         * Engagement metrics
         */
        likes: {
            type: Number,
            default: 0,
        },

        comments: {
            type: Number,
            default: 0,
        },

        shares: {
            type: Number,
            default: 0,
        },
    },
    {
        /**
         * Automatically adds:
         * - createdAt
         * - updatedAt
         */
        timestamps: true,
    }
);



const Post = mongoose.model("Post", newPostSchema);

export default Post;