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
        authorUid: {
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
        description: {
            type: String,
            default: "",
            trim: true,
        },

        /**
         * Optional image attached to the post
         */
        postImages: {
            type: String,
            default: null,
        },

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



const newPost = mongoose.model("newPost", newPostSchema);

export default newPost;