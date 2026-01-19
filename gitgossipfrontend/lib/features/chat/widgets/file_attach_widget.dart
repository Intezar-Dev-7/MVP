import 'package:flutter/material.dart';

class FileAttachment extends StatelessWidget {
  final String fileName;
  final String fileSize;

  const FileAttachment({
    super.key,
    required this.fileName,
    required this.fileSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1418),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1F5E3F),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.insert_drive_file,
              color: Color(0xFF00A884),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fileName,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(height: 2),
              Text(
                fileSize,
                style: const TextStyle(color: Colors.white60, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00A884),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.download, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
