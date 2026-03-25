class DiscoverUser {
  final String id;
  final String fullName;
  final String? username;
  final String? userBio;
  final String profilePic;
  final List<String> techStack;

  DiscoverUser({
    required this.id,
    required this.fullName,
    this.username,
    this.userBio,
    required this.profilePic,
    required this.techStack,
  });

  factory DiscoverUser.fromJson(Map<String, dynamic> json) {
    return DiscoverUser(
      id: json['_id'],
      fullName: json['fullName'] ?? '',
      username: json['username'],
      userBio: json['userBio'],
      profilePic: json['profilePic'] ?? '',
      techStack: json['techStack'] != null
          ? List<String>.from(json['techStack'])
          : [],
    );
  }
}
