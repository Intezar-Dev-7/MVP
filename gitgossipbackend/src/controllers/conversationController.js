import Conversation from "../models/conversationModel.js";

// create conversation Or return existing one 
export const createOrGetConversation = async (req, res) => {
    try {
        const { senderId, receiverId } = req.body;

        let conversation = await Conversation.findOne({
            participants: { $all: [senderId, receiverId] }
        });
        if (!conversation) {
            conversation = await Conversation.create({
                participants: [senderId, receiverId]
            });

        }
        res.status(200).json(conversation);

    } catch (error) {
        res.status(500).json({ message: error.message });
    }


};