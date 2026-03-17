/*MessageModel = Each individual message inside that chat
A conversation can have 1000s of messages.
This model stores each:
Text message
Image message
Call event message
*/

class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String text;
  final bool seen;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.text,
    required this.seen,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      conversationId: json['conversationId'],
      senderId: json['senderId'],
      text: json['text'],
      seen: json['seen'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
