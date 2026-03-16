import 'package:socket_io_client/socket_io_client.dart' as IO;

// socket_service → manages socket connection
class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  IO.Socket? socket;

  void connect() {
    if (socket != null && socket!.connected) {
      return;
    }
    socket = IO.io(
      "http://10.148.217.72:3000",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket!.connect();
    listenEvents();
  }

  // Listen Core Socket Events
  void listenEvents() {
    socket!.onConnect((_) {
      print("✅ Socket Connected: ${socket!.id}");
    });

    socket!.onDisconnect((_) {
      print("❌ Socket Disconnected");
    });

    socket!.onConnectError((error) {
      print("⚠️ Connection Error: $error");
    });

    socket!.onError((error) {
      print("⚠️ Socket Error: $error");
    });
  }

  // Emit Events //
  // Join Chat Room
  void joinConversation(String conversationId) {
    socket?.emit("joinConversation", conversationId);
  }

  // Send Message
  void sendMessage(Map<String, dynamic> data) {
    socket?.emit("sendMessage", data);
  }

  // Listen Message
  void onReceiveMessage(Function(dynamic) callback) {
    socket?.on("receiveMessage", callback);
  }

  // Message Seen
  void onMessageSeen(Function(dynamic) callback) {
    socket?.on("messagesSeen", callback);
  }
}
