import 'package:flutter/material.dart';
import 'package:gitgossip/features/post/models/post_model.dart';
import 'package:gitgossip/features/post/services/post_services.dart';
import 'package:gitgossip/features/userProfile/widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late Future<List<PostModel>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = PostServices().fetchUsersPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Your Posts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),

        /// 👇 Dynamic posts
        FutureBuilder<List<PostModel>>(
          future: _postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  "Failed to load posts",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            final posts = snapshot.data ?? [];

            if (posts.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  "No posts yet",
                  style: TextStyle(color: Colors.white60),
                ),
              );
            }

            return Column(
              children: posts.map((post) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ProjectCard(
                    imageUrl:
                        post.postImages ??
                        "https://via.placeholder.com/600x400",
                    title: post.description,
                    description: post.githubUrl ?? "No Github Link Avaiable",
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
