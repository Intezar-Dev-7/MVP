import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitgossip/features/chat/models/message_model.dart';
import 'package:gitgossip/features/chat/services/chat_services.dart';
import 'package:gitgossip/features/chat/widgets/chat_app_bar.dart';
import 'package:gitgossip/features/chat/widgets/chat_input_bar_widget.dart'
    show ChatInputBar;
import 'package:gitgossip/features/chat/message_widgets/receive_message.dart';
import 'package:gitgossip/features/chat/message_widgets/sent_message_widget.dart';

class MessageScreen extends StatefulWidget {
  final String conversationId;
  final String receiverId;
  final String receiverName;
  final String receiverAvatar;

  const MessageScreen({
    super.key,
    required this.conversationId,
    required this.receiverId,
    required this.receiverName,
    required this.receiverAvatar,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final ChatServices chatServices = ChatServices();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();

  late String currentUserId;

  final List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();

    currentUserId = FirebaseAuth.instance.currentUser!.uid;

    initializeChat();
  }

  /// Main initialization flow
  void initializeChat() async {
    await loadOldMessages();

    chatServices.joinConversation(widget.conversationId);

    chatServices.listenMessages((data) {
      final message = MessageModel.fromJson(data);

      setState(() {
        messages.insert(0, message);
      });

      scrollToBottom();
    });

    chatServices.markMessagesSeen(
      conversationId: widget.conversationId,
      userId: currentUserId,
    );
  }

  /// Load chat history
  Future<void> loadOldMessages() async {
    final oldMessages = await chatServices.fetchMessages(widget.conversationId);

    final parsedMessages = oldMessages
        .map((m) => MessageModel.fromJson(m))
        .toList();

    setState(() {
      messages.addAll(parsedMessages.reversed);
    });

    scrollToBottom();
  }

  /// Send message
  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    chatServices.sendMessage(
      conversationId: widget.conversationId,
      senderId: currentUserId,
      text: text,
    );

    _inputController.clear();
  }

  /// Scroll helper
  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String formatTime(DateTime date) {
    final hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  @override
  void dispose() {
    chatServices.socketService.socket!.off("receiveMessage");
    _scrollController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        context: context,
        name: widget.receiverName,
        avatar: widget.receiverAvatar,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                final isMe = msg.senderId == currentUserId;

                if (isMe) {
                  return SentMessage(
                    text: msg.text,
                    time: formatTime(msg.createdAt),
                    isDelivered: msg.seen,
                  );
                } else {
                  return ReceivedMessage(
                    time: formatTime(msg.createdAt),
                    child: Text(
                      msg.text,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  );
                }
              },
            ),
          ),
          ChatInputBar(inputController: _inputController, onSend: sendMessage),
        ],
      ),
    );
  }
}
