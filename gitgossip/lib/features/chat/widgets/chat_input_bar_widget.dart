import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatInputBar extends StatefulWidget {
  final TextEditingController inputController;
  const ChatInputBar({
    required this.inputController,
    super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {

  bool _isExpanded = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.inputController.addListener(() {
      final hasText = widget.inputController.text
          .trim()
          .isNotEmpty;
      if (hasText != _hasText) {
        setState(() {
          _hasText = hasText;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: const Color(0xFF1F2C33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isExpanded) _buildExpandedActions(),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildExpandButton(),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1418),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFF00A884), width: 1.5),
                  ),
                  child: TextField(
                    controller: widget.inputController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF0D1418),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(_hasText ? Icons.send : Icons.mic, color: Colors.white70),
                  onPressed: () {
                    if (_hasText) {
                      // TODO: Handle message sending
                    } else {
                      // TODO: Handle voice recording
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildExpandButton() {
    return AnimatedRotation(
      turns: _isExpanded ? 0.125 : 0, // 45 degrees when expanded
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _isExpanded
                ? Colors.green.withOpacity(0.15)
                : Colors.black,
            shape: BoxShape.circle,
            border: Border.all(
              color: _isExpanded
                  ? Colors.green.withOpacity(0.3)
                  : Colors.grey,
              width: 1,
            ),
          ),
          child: Icon(
            Icons.add_rounded,
            color: _isExpanded ? Colors.green : Colors.grey,
            size: 24,
          ),
        ),
      ),
    );
  }


  Widget _buildExpandedActions() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionChip(
              icon: Icons.image_rounded,
              label: 'Photo',
              color: const Color(0xFFE91E63),
              onTap: () {
                setState(() => _isExpanded = false);
              },
            ),
            const SizedBox(width: 12),
            _buildActionChip(
              icon: Icons.code_rounded,
              label: 'Code',
              color: Colors.green,
              onTap: () {
                setState(() => _isExpanded = false);
              },
            ),
            const SizedBox(width: 12),
            _buildActionChip(
              icon: Icons.insert_drive_file_rounded,
              label: 'File',
              color: Colors.green,
              onTap: () {
                setState(() => _isExpanded = false);
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
            ),
          ],
        ),
      ),
    );
  }
}
