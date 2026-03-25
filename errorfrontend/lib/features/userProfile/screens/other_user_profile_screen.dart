import 'package:flutter/material.dart';

class OtherUserProfileScreen extends StatefulWidget {
  final String name;
  final String avatar;

  const OtherUserProfileScreen({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300.0,
              backgroundColor: const Color(0xFF1F2C33),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  color: Colors.black,
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(widget.avatar),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                _buildInfoSection('About', 'Busy', Icons.info_outline),
                const Divider(color: Colors.white24),
                _buildMediaSection(),
                const Divider(color: Colors.white24),
                _buildActionsSection(),
                const Divider(color: Colors.white24),
                _buildDangerZone(),
                const SizedBox(height: 24),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white54, fontSize: 14),
      ),
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
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildDangerZone() {
    return Column(
      children: [
        _buildDangerTile(
          Icons.block,
          'Block ${widget.name}',
          color: Colors.red,
        ),
        _buildDangerTile(
          Icons.thumb_down,
          'Report ${widget.name}',
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildDangerTile(
    IconData icon,
    String title, {
    Color color = Colors.white,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontSize: 16)),
    );
  }
}
