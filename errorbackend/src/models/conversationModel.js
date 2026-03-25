// models/conversation.js
import mongoose from "mongoose";

const conversationSchema = new mongoose.Schema(
    {
        participants: {

            type: [String],

            required: true

        },

        lastMessage: {
            type: mongoose.Schema.Types.ObjectId,
            // ref: "Message"
        },
        lastMessageSenderId: {
            type: String
        }

    },
    { timestamps: true }
);

const Conversation = mongoose.model("Conversation", conversationSchema);
export default Conversation;