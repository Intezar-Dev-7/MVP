// Sample data model
class Developer {
  final String name;
  final String username;
  final String avatarUrl;
  final String description;
  final List<String> techStack;
  final int matchPercentage;

  Developer({
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.description,
    required this.techStack,
    required this.matchPercentage,
  });
}

// Example data
final List<Developer> developers = [
  Developer(
    name: 'Jordan Lee',
    username: '@jordanlee',
    avatarUrl: 'https://your-avatar-url.com/jordan.png',
    description:
        'Backend engineer specializing in scalable microservices. Love working with cloud-native technologies.',
    techStack: ['NodeJS', 'TypeScript', 'Docker', 'Kubernetes', 'Redis'],
    matchPercentage: 80,
  ),
  Developer(
    name: 'Maya Patel',
    username: '@mayapatel',
    avatarUrl: 'https://your-avatar-url.com/maya.png',
    description:
        'Frontend developer passionate about building beautiful and usable interfaces.',
    techStack: ['React', 'NodeJS'],
    matchPercentage: 81,
  ),
];
