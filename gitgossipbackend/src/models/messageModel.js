// models/message.js
import mongoose from "mongoose";


const messageSchema = new mongoose.Schema(
    {
        conversationId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Conversation",
            required: true
        },

        senderId: {
            type: String, // fireabae uid,
            required: true
        },

        text: {
            type: String,
            required: true
        },

        seen: {
            type: Boolean,
            default: false
        }

    },
    { timestamps: true }
);
const Message = mongoose.model("Message", messageSchema);
export default Message;
