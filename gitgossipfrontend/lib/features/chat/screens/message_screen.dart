import 'package:flutter/material.dart';
import 'package:gitgossip/features/chat/widgets/chat_app_bar.dart';
import 'package:gitgossip/features/chat/widgets/chat_input_bar_widget.dart'
    show ChatInputBar;
import 'package:gitgossip/features/chat/widgets/code_snippet_widget.dart';
import 'package:gitgossip/features/chat/widgets/file_attach_widget.dart';
import 'package:gitgossip/features/chat/widgets/receive_message.dart';
import 'package:gitgossip/features/chat/widgets/sent_message_widget.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        context: context,
        name: 'Maya Rodriguez',
        status: 'Offline',
        avatarColor: const Color(0xFF1F5E3F),
        avatarInitial: 'M',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                ReceivedMessage(
                  time: '8:07 PM',
                  child: CodeSnippet(
                    language: 'typescript',
                    code: '''typescript
'text-primary'>async 'text-primary
  'text-primary'>try {
    "text-primary">const decoded =
} "text-primary">.catch (error)
    "text-primary">return { succes
}
}''',
                  ),
                ),
                const SizedBox(height: 8),
                SentMessage(
                  time: '3:34 PM',
                  text:
                      'Perfect! That\'s much cleaner. The error handling looks good now 👍',
                  isDelivered: true,
                ),
                const SizedBox(height: 8),
                ReceivedMessage(
                  time: '8:09 PM',
                  child: const Text(
                    'Awesome! Also sharing the updated component file:',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                const SizedBox(height: 8),
                ReceivedMessage(
                  time: '8:14 PM',
                  child: FileAttachment(
                    fileName: 'AuthProvider.tsx',
                    fileSize: '3.2 KB',
                  ),
                ),
              ],
            ),
          ),
          ChatInputBar(
            inputController: _inputController,
          ),
        ],
      ),
    );
  }
}
