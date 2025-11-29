import 'package:flutter/material.dart';

class OtherUserProfileScreen extends StatelessWidget {
  const OtherUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            backgroundColor: const Color(0xFF1F2C33),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'John Doe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Image.network(
                'https://static.vecteezy.com/system/resources/thumbnails/008/062/987/small/travel-to-the-beautiful-colorful-majestic-waterfall-in-national-park-forest-during-autumn-soft-water-of-the-stream-in-the-natural-park-photo.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 16),
                _buildInfoSection('About', 'Busy', Icons.info_outline),
                const Divider(color: Colors.white24),
                _buildMediaSection(),
                const Divider(color: Colors.white24),
                _buildActionsSection(),
                const Divider(color: Colors.white24),
                _buildDangerZone(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 14)),
    );
  }

  Widget _buildMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Media, links, and docs',
            style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://picsum.photos/200/300?random=$index', // Placeholder images
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection() {
    return Column(
      children: [
        _buildActionsTile(Icons.notifications_off, 'Mute notifications'),
        _buildActionsTile(Icons.music_note, 'Custom notifications'),
        _buildActionsTile(Icons.image, 'Media visibility'),
      ],
    );
  }

  Widget _buildActionsTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }

  Widget _buildDangerZone() {
    return Column(
      children: [
        _buildDangerTile(Icons.block, 'Block John Doe', color: Colors.red),
        _buildDangerTile(Icons.thumb_down, 'Report John Doe', color: Colors.red),
      ],
    );
  }

  Widget _buildDangerTile(IconData icon, String title, {Color color = Colors.white}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontSize: 16)),
    );
  }
}
