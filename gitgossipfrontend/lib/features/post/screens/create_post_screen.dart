import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gitgossip/core/widgets/custom_snack_bar.dart';
import 'package:gitgossip/features/post/services/post_services.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];
  bool isPosting = false;

  // Controllers
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController githubController = TextEditingController();
  final TextEditingController liveDemoController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    githubController.dispose();
    liveDemoController.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    final images = await _picker.pickMultiImage(imageQuality: 70);
    if (images.isNotEmpty) {
      setState(() {
        selectedImages = images;
      });
    }
  }

  // Create new post fucntion
  Future<void> createUserPost() async {
    if (isPosting) return;

    // Validation
    if (titleController.text.trim().isEmpty) {
      showAnimatedSnackBar(context, "Title is required");
      return;
    }

    if (descriptionController.text.trim().isEmpty && selectedImages.isEmpty) {
      showAnimatedSnackBar(context, "Add a description or at least 1 image");
      return;
    }

    setState(() => isPosting = true);

    try {
      await PostServices().createPost(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        githubUrl: githubController.text.trim().isEmpty
            ? null
            : githubController.text.trim(),
        liveDemoUrl: liveDemoController.text.trim().isEmpty
            ? null
            : liveDemoController.text.trim(),
        images: selectedImages,
      );

      if (!mounted) return;

      // Clear state
      selectedImages.clear();
      titleController.clear();
      descriptionController.clear();
      githubController.clear();
      liveDemoController.clear();

      setState(() => isPosting = false);

      showAnimatedSnackBar(context, "Post created successfully");
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      setState(() => isPosting = false);
      showAnimatedSnackBar(context, e.toString());
    }
  }

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
            onPressed: isPosting ? null : createUserPost,
            child: isPosting
                ? CircularProgressIndicator(color: Colors.green)
                : Text("Post"),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE PICKER
              GestureDetector(
                onTap: pickImages,
                child: Container(
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
                        'Add Images',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        'Tap to upload screenshots or images',
                        style: TextStyle(color: Colors.white54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),

              // SHOW SELECTED IMAGES
              if (selectedImages.isNotEmpty)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: selectedImages
                      .map(
                        (img) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(img.path),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                ),

              SizedBox(height: 24),
              // TITLE FIELD
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF202124),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: TextField(
                  controller: titleController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Post title (required)",
                    hintStyle: TextStyle(color: Colors.white38),
                    icon: Icon(Icons.title, color: Colors.green),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // DESCRIPTION FIELD
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF202124),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: TextField(
                  controller: descriptionController,
                  minLines: 5,
                  maxLines: 8,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        "What's on your mind? Share ideas, projects, or code...",
                    hintStyle: TextStyle(color: Colors.white38, fontSize: 16),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // OPTIONAL: GITHUB LINK
              _buildField(
                controller: githubController,
                hint: "GitHub Repository (optional)",
                icon: Icons.code,
              ),

              SizedBox(height: 14),

              // OPTIONAL: LIVE DEMO URL
              _buildField(
                controller: liveDemoController,
                hint: "Live Demo URL (optional)",
                icon: Icons.link,
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // REUSABLE FIELD WIDGET
  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF202124),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: icon != null ? Icon(icon, color: Colors.green) : null,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white38),
        ),
      ),
    );
  }
}
