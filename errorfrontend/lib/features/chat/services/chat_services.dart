// chat_services → uses socket + API for chat features
/*chat_services.dart  handles chat operations like:
sending messages
listening for messages
joining conversations
fetching messages from API
*/
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:gitgossip/core/config/api.dart';
import 'package:gitgossip/features/chat/services/socket_service.dart';
import 'package:gitgossip/features/userProfile/models/user_model.dart';
import 'package:http/http.dart' as http;

class ChatServices {
  // This Function will fetch list of users from backend and display them in all chat screens, so that user can chat with anybody ,
  // This feature is temporary to test 1-1 chating feature, later will improve it
  Future<List<UserModel>> fetchListOfUsers() async {
    try {
      final currentUid = FirebaseAuth.instance.currentUser!.uid;
      final response = await http.get(
        Uri.parse("$baseUrl/user/fetchAllUsers/$currentUid"),
      );
      if (response.statusCode == 200) {
        // final List<dynamic> data = jsonDecode(response.body);
        // return data.map((item) => UserModel.fromJson(item)).toList();
        final decoded = jsonDecode(response.body);

        if (decoded is List) {
          return decoded.map((item) => UserModel.fromJson(item)).toList();
        } else if (decoded is Map && decoded["users"] is List) {
          return (decoded["users"] as List)
              .map((item) => UserModel.fromJson(item))
              .toList();
        } else {
          throw Exception("Unexpected response format: ${decoded.runtimeType}");
        }
      } else {}
    } catch (e) {
      throw Exception("Server error: $e");
    }
    return [];
  }

  final SocketService socketService = SocketService();

  void joinConversation(String conversationId) {
    socketService.joinConversation(conversationId);
  }

  void sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
  }) {
    socketService.sendMessage({
      "conversationId": conversationId,
      "senderId": senderId,
      "text": text,
    });
  }

  void listenMessages(Function(dynamic) callBack) {
    socketService.onReceiveMessage(callBack);
  }

  //
  Future<dynamic> createOrGetConversation(String receiverId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/conversation/createConversation"),
      body: jsonEncode({
        "senderId": FirebaseAuth.instance.currentUser!.uid,
        "receiverId": receiverId,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      // return jsonDecode(response.body);
      final decoded = jsonDecode(response.body);

      if (decoded["_id"] != null) {
        return decoded;
      } else if (decoded["conversation"] != null) {
        return decoded["conversation"];
      } else {
        throw Exception("Invalid conversation response");
      }
    } else {
      throw Exception("Failed to create conversation: ${response.body}");
    }
  }

  Future<List<dynamic>> fetchMessages(String conversationId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/message/$conversationId"),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is List) {
          return decoded;
        } else if (decoded is Map && decoded["messages"] is List) {
          return decoded["messages"];
        } else {
          throw Exception("Unexpected messages format");
        }
      } else {
        print("Failed to fetch messages");
      }
    } catch (e) {
      throw Exception("Error fetching messages: $e");
    }

    return [];
  }

  Future<void> markMessagesSeen({
    required String conversationId,
    required String userId,
  }) async {
    try {
      await http.patch(
        Uri.parse("$baseUrl/message/seen"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"conversationId": conversationId, "userId": userId}),
      );
    } catch (e) {
      throw Exception("Error in seeing message: $e");
    }
  }
}
