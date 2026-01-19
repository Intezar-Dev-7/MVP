class PostModel {
  /// MongoDB document ID (_id)
  final String id;

  /// Firebase UID of the author
  final String authorUid;

  /// Author username (denormalized)
  final String username;

  /// Author profile image URL
  final String? userProfilePic;

  /// Post title
  final String title;

  /// Post description / caption
  final String description;

  /// Optional post image
  final String? postImages;

  /// Optional GitHub repository link
  final String? githubUrl;

  /// Optional live demo link
  final String? liveDemoUrl;

  /// Engagement metrics
  final int likes;
  final int comments;
  final int shares;

  final DateTime createdAt;
  final DateTime? updatedAt;

  PostModel({
    required this.id,
    required this.authorUid,
    required this.username,
    this.userProfilePic,
    required this.title,
    required this.description,
    this.postImages,
    this.githubUrl,
    this.liveDemoUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.createdAt,
    this.updatedAt,
  });

  // ---------- FROM JSON ----------
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'],
      authorUid: json['authorUid'],
      username: json['username'],
      userProfilePic: json['userProfilePic'],
      title: json['title'],
      description: json['description'] ?? '',
      postImages: json['postImages'],
      githubUrl: json['githubUrl'],
      liveDemoUrl: json['liveDemoUrl'],
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      shares: json['shares'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  // ---------- TO JSON ----------
  Map<String, dynamic> toJson() {
    return {
      "authorUid": authorUid,
      "username": username,
      "userProfilePic": userProfilePic,
      "title": title,
      "description": description,
      "postImages": postImages,
      "githubUrl": githubUrl,
      "liveDemoUrl": liveDemoUrl,
      "likes": likes,
      "comments": comments,
      "shares": shares,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }

  // ---------- COPY WITH ----------
  PostModel copyWith({
    String? id,
    String? authorUid,
    String? username,
    String? userProfilePic,
    String? title,
    String? description,
    String? postImages,
    String? githubUrl,
    String? liveDemoUrl,
    int? likes,
    int? comments,
    int? shares,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      authorUid: authorUid ?? this.authorUid,
      username: username ?? this.username,
      userProfilePic: userProfilePic ?? this.userProfilePic,
      title: title ?? this.title,
      description: description ?? this.description,
      postImages: postImages ?? this.postImages,
      githubUrl: githubUrl ?? this.githubUrl,
      liveDemoUrl: liveDemoUrl ?? this.liveDemoUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
