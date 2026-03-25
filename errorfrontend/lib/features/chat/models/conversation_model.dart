/*ConversationModel = The chat room
This represents:
A 1-on-1 chat between two users
OR a group chat (if you add that later)
Contains metadata, last message, participants, etc.
📌 It does NOT store individual messages, only meta info.
*/
class Conversation {
  final String id;
  final List<String> participants;
  final String? lastMessage;
  final String? lastMessageSenderId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Conversation({
    required this.id,
    required this.participants,
    this.lastMessage,
    this.lastMessageSenderId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['_id'],
      participants: List<String>.from(json['participants']),
      lastMessage: json['lastMessage'],
      lastMessageSenderId: json['lastMessageSenderId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
