// fetch all messages in a conversation

import Message from "../models/messageModel.js";

export const getMessages = async (req, res) => {
    try {
        const { conversationId } = req.params;
        const messages = await Message.find({ conversationId }).sort({ created: 1 });
        res.status(200).json(messages);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

// Mark Message as seen 
export const markMessageSeen = async (req, res) => {
    try {
        const { conversationId, userId } = req.body;
        await Message.updateMany(
            {
                conversationId,
                senderId: { $ne: userId },
                seen: false
            },
            {
                $set: { seen: true }
            }
        );
        res.status(200).json({ message: "Messages marked as seen" });

    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}