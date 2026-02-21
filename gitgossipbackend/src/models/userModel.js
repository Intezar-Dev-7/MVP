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
            immutable: true,
        },

        /**
         * User's display name
         */
        fullName: {
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
            lowercase: true,
            trim: true,
            minlength: 3,
            maxlength: 20,
            match: /^[a-z0-9_]+$/,


        },

        /**
         * User email address
         */
        email: {
            type: String,
            required: true,
            unique: true,
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
            match: /^\+[1-9]\d{7,14}$/,
        },


        /**
         * Short user bio
         */
        userBio: {
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
        techStack: {
            type: [String],
            default: [],
            lowercase: true,
            index: true,
        },
        /**
         * Social media & portfolio links
         */
        socialLinks: {
            instagram: { type: String, trim: true },
            github: { type: String, trim: true, match: /^https?:\/\// },
            linkedin: { type: String, trim: true, match: /^https?:\/\// },
            portfolio: { type: String, trim: true, match: /^https?:\/\// },

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




const User = mongoose.model("User", userSchema);
export default User;
/*
mongoose.model() = creates a link between schema and MongoDB collection.
export default = allows you to import and use it anywhere else in your app.
*/
