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

// Sample data
final List<FeedPostModel> feedData = [
  FeedPostModel(
    name: 'Alex Kumar',
    username: '@alexkodes',
    time: 'about an hour ago',
    avatarUrl: 'https://your-avatar-url.com/alex.png',
    content:
        'Built a Flutter app for habit tracking with local notifications. Super smooth animations and offline-first approach. Check it out!',
    imageUrl: 'https://your-image-url.com/river.jpg',
    likes: 15,
    comments: 3,
    shares: 2,
  ),
  FeedPostModel(
    name: 'Hemant Kumar',
    username: '@alexkodes',
    time: 'about an hour ago',
    avatarUrl: 'https://your-avatar-url.com/alex.png',
    content:
        'Built a Flutter app for habit tracking with local notifications. Super smooth animations and offline-first approach. Check it out!',
    imageUrl: 'https://your-image-url.com/river.jpg',
    likes: 15,
    comments: 3,
    shares: 2,
  ),
  // Add more sample FeedPost objects as needed
];
