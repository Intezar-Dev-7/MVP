import mongoose from "mongoose";

/**
 * User Schema
 * -----------
 * This schema represents an application user.
 * Authentication is handled by Firebase,
 * and MongoDB is used to store additional user data.
 */
const userSchema = new mongoose.Schema(
    {
        /**
         * Firebase UID
         * - Comes from Firebase Authentication
         * - Acts as the primary identifier for a user
         */
        firebaseUid: {
            type: String,
            required: true,
            unique: true,
            index: true,
        },

        /**
         * User's display name
         */
        name: {
            type: String,
            trim: true,
        },

        /**
         * Unique username chosen by the user
         */
        username: {
            type: String,
            unique: true,
            sparse: true,
            index: true,
            lowercase: true,
            trim: true,
        },

        /**
         * User email address
         */
        email: {
            type: String,
            unique: true,
            sparse: true,
            lowercase: true,
            trim: true,
        },

        /**
         * User phone number
         */
        userPhoneNumber: {
            type: String,
            unique: true,
            sparse: true,
        },

        /**
         * Short user bio
         */
        bio: {
            type: String,
            sparse: true,
            trim: true,
        },

        /**
         * URL of user's profile picture
         */
        profilePic: {
            type: String,
        },

        /** 🔥 NEW: Skills */
        skills: {
            type: [String],
            default: [],
            index: true,
        },
        /**
         * Social media & portfolio links
         */
        socialLinks: {
            instagram: {
                type: String,
                trim: true,
            },
            github: {
                type: String,
                trim: true,
            },
            linkedin: {
                type: String,
                trim: true,
            },
            portfolio: {
                type: String,
                trim: true,
            },
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



const newUser = mongoose.model(
    "newUser",
    userSchema
);

export default newUser;

/*
mongoose.model() = creates a link between schema and MongoDB collection.
export default = allows you to import and use it anywhere else in your app.
*/
