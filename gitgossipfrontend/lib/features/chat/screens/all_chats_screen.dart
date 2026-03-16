import 'package:flutter/material.dart';
import 'package:gitgossip/features/chat/screens/message_screen.dart';
import 'package:gitgossip/features/chat/services/chat_services.dart';
import 'package:gitgossip/features/chat/widgets/chat_tile_widget.dart';
import 'package:gitgossip/features/userProfile/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<UserModel> users = [];
  bool isLoading = true;
  final ChatServices _chatServices = ChatServices();

  @override
  void initState() {
    super.initState();
    _loadListOfUsersFromBackend();
  }

  Future<void> _loadListOfUsersFromBackend() async {
    final fetchedUsers = await _chatServices.fetchListOfUsers();
    setState(() {
      users = fetchedUsers;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert, size: 28),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search chat & messages...',
                  hintStyle: TextStyle(color: Colors.white54),
                  icon: Icon(Icons.search, color: Colors.white54),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Chat List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: users.length,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ChatTile(
                        name: user.fullName,
                        message: "start Convesation",
                        time: "",
                        avatar: user.profilePic,
                        onTap: () async {
                          final conversation = await _chatServices
                              .createOrGetConversation(user.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MessageScreen(
                                conversationId: conversation["_id"],
                                receiverId: user.id,
                                receiverName: user.fullName,
                                receiverAvatar: user.profilePic,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
