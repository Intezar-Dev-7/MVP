import 'package:flutter/material.dart';
import 'package:gitgossip/features/post/models/post_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gitgossip/features/post/services/post_services.dart';
import 'package:gitgossip/features/post/screens/create_post_screen.dart';
import 'package:gitgossip/core/widgets/custom_snack_bar.dart';

class ProjectCard extends StatefulWidget {
  final List<String> imageUrls;
  final String title;
  final String postDescription;
  final PostModel post; //changes by aditya
  final VoidCallback onRefresh; //changes by aditya

  const ProjectCard({
    super.key,
    required this.imageUrls,
    required this.title,
    required this.postDescription,
    required this.post, //changes by aditya
    required this.onRefresh, //changes by aditya
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Column(
              //new changes by aditya
              children: [
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.imageUrls.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          widget.imageUrls[index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                if (widget.imageUrls.length > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.imageUrls.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: currentIndex == index ? 8 : 6,
                        height: currentIndex == index ? 8 : 6,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.green
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // changes by aditya (replaced Text from Row)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) async {
                        //changes by aditya
                        if (value == "delete") {
                          try {
                            await PostServices().deletePost(widget.post.id);
                            if (!context.mounted) return;

                            showAnimatedSnackBar(
                              context,
                              "Post deleted successfully",
                            );
                            widget.onRefresh();
                          } catch (e) {
                            if (!context.mounted) return;
                            showAnimatedSnackBar(
                              context,
                              "Failed to delete post",
                            );
                          }
                        }

                        if (value == "edit") {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CreatePostScreen(post: widget.post),
                            ),
                          );

                          widget.onRefresh();
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: "edit", child: Text("Edit Post")),
                        PopupMenuItem(
                          value: "delete",
                          child: Text("Delete Post"),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.postDescription,
                  style: const TextStyle(fontSize: 16, color: Colors.white60),
                ),

                // --- NEW ACTION BUTTONS SECTION ---
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Add Like logic
                      },
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Add Comment logic
                      },
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Iconsax.share, color: Colors.white),
                      onPressed: () {
                        // Add Share logic
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
