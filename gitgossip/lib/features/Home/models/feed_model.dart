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
    avatarUrl: 'https://images.stockcake.com/public/f/9/7/f9746331-150a-45a9-8cce-35223c1411ca_large/sunset-beach-waves-stockcake.jpg',
    content:
        'Built a Flutter app for habit tracking with local notifications. Super smooth animations and offline-first approach. Check it out!',
    imageUrl: 'https://images.pexels.com/photos/994605/pexels-photo-994605.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    likes: 15,
    comments: 3,
    shares: 2,
  ),
  FeedPostModel(
    name: 'Hemant Kumar',
    username: '@alexkodes',
    time: 'about an hour ago',
    avatarUrl: 'https://images.stockcake.com/public/f/9/7/f9746331-150a-45a9-8cce-35223c1411ca_large/sunset-beach-waves-stockcake.jpg',
    content:
        'Built a Flutter app for habit tracking with local notifications. Super smooth animations and offline-first approach. Check it out!',
    imageUrl: 'https://images.pexels.com/photos/994605/pexels-photo-994605.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    likes: 15,
    comments: 3,
    shares: 2,
  ),
  // Add more sample FeedPost objects as needed
];
