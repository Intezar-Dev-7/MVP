import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Create Post',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {}, // Implement post logic
            child: Text(
              'Post',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 18),
                padding: const EdgeInsets.symmetric(vertical: 34),
                decoration: BoxDecoration(
                  color: Color(0xFF202124),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(14),
                      child: Icon(Icons.image, size: 44, color: Colors.green),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Add Image',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Upload a screenshot or image',
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF202124),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: TextField(
                  minLines: 5,
                  maxLines: 8,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        "What's on your mind? Share your ideas, code, or projects...",
                    hintStyle: TextStyle(color: Colors.white38, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Links (Optional)',
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF202124),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                child: Row(
                  children: [
                    Icon(Icons.code, color: Colors.green, size: 25),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'GitHub repository URL',
                          hintStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF202124),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                child: Row(
                  children: [
                    Icon(Icons.link, color: Colors.blue, size: 25),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Live demo URL',
                          hintStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
