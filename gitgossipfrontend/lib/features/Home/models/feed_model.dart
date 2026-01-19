class FeedPostModel {
  final String name;
  final String username;
  final String time;
  final String avatarUrl;
  final String content;
  final String imageUrl;
  final int likes, comments, shares;

  FeedPostModel({
    required this.name,
    required this.username,
    required this.time,
    required this.avatarUrl,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}
