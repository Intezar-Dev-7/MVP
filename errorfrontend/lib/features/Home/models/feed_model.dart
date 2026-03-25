class FeedPost {
  final String id;
  final String firebaseUid;
  final String username;
  final String userProfilePic;
  final String title;
  final String description;
  final List<String> images;
  final int likes;
  final int comments;
  final DateTime createdAt;

  FeedPost({
    required this.id,
    required this.firebaseUid,
    required this.username,
    required this.userProfilePic,
    required this.title,
    required this.description,
    required this.images,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  factory FeedPost.fromJson(Map<String, dynamic> json) {
    return FeedPost(
      id: json['id'] ?? '',
      firebaseUid: json['firebaseUid'] ?? '',
      username: json['username'] ?? '',
      userProfilePic: json['userProfilePic'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',

      /// 🔥 HANDLE ARRAY SAFELY
      images: json['images'] != null ? List<String>.from(json['images']) : [],

      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
