// handle connection
// listen sendMessage
// emit receiveMessage

import Conversation from "../models/conversationModel.js";
import Message from "../models/messageModel.js";


export const initSocket = (io) => {

    io.on("connection", (socket) => {

        console.log("User connected:", socket.id);

        // join conversation room
        socket.on("joinConversation", (conversationId) => {
            socket.join(conversationId);
        });

        // send message
        socket.on("sendMessage", async (data) => {

            const { conversationId, senderId, text } = data;

            const message = await Message.create({
                conversationId,
                senderId,
                text,
            });
            await Conversation.findByIdAndUpdate(conversationId, {
                lastMessage: message._id,
                lastMessageSenderId: senderId,
            })
            // emit message to all users in that conversation
            io.to(conversationId).emit("receiveMessage", message);
        });

        socket.on("disconnect", () => {
            console.log("User disconnected:", socket.id);
        });

        socket.on("markSeen", async (data) => {

            const { conversationId, userId } = data;

            await Message.updateMany(
                {
                    conversationId,
                    senderId: { $ne: userId },
                    seen: false
                },
                { $set: { seen: true } }
            );

            io.to(conversationId).emit("messagesSeen", {
                conversationId
            });

        });


    });

};