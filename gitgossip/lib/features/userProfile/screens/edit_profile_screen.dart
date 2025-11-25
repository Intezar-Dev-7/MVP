import 'package:flutter/material.dart';
import 'package:gitgossip/features/userProfile/widgets/skill_chip.dart';
import 'package:gitgossip/features/userProfile/widgets/social_linked_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(
    text: 'johndoe@gmail.com',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '9098541236',
  );
  final TextEditingController _nameController = TextEditingController(
    text: 'John Doe',
  );
  final TextEditingController _usernameController = TextEditingController(
    text: 'johndoe',
  );
  final TextEditingController _customSkillController = TextEditingController();
  final TextEditingController _githubController = TextEditingController(
    text: 'github.com/username',
  );
  final TextEditingController _linkedinController = TextEditingController(
    text: 'linkedin.com/in/username',
  );
  final TextEditingController _twitterController = TextEditingController(
    text: 'twitter.com/username',
  );
  final TextEditingController _instagramController = TextEditingController(
    text: 'instagram.com/username',
  );
  final TextEditingController _portfolioController = TextEditingController(
    text: 'yourportfolio.com',
  );

  final List<String> _selectedSkills = [
    'React',
    'Vue',
    'Angular',
    'TypeScript',
    'JavaScript',
    'Python',
    'Java',
    'Golang',
  ];

  void _addCustomSkill() {
    if (_customSkillController.text.isNotEmpty) {
      setState(() {
        _selectedSkills.add(_customSkillController.text);
        _customSkillController.clear();
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      _selectedSkills.remove(skill);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0F0D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set up your developer profile to get started',
              style: TextStyle(color: Colors.white60, fontSize: 14),
            ),
            const SizedBox(height: 24),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1A1A1A),
                      border: Border.all(
                        color: const Color(0xFF2A2A2A),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 50,
                      color: Colors.white38,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildTextField(
              label: 'Email',
              controller: _emailController,
              required: true,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Phone',
              controller: _phoneController,
              required: true,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Full Name',
              controller: _nameController,
              required: true,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Username',
              controller: _usernameController,
              required: true,
              helperText: 'Only lowercase letters, numbers, and underscores',
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Bio / Short Intro',
              controller: _bioController,
              maxLines: 5,
              maxLength: 160,
              hintText:
                  'Tell us about yourself... (e.g., Full-stack developer passionate about open source)',
            ),
            const SizedBox(height: 32),
            const Text(
              'Tech Stack / Skills',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _selectedSkills
                  .map(
                    (skill) => SkillChip(
                      label: skill,
                      onRemove: () => _removeSkill(skill),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _customSkillController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Add custom skill...',
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _addCustomSkill,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Social Links',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            SocialLinkField(
              icon: Icons.code,
              iconColor: const Color(0xFF4CAF50),
              controller: _githubController,
              backgroundColor: const Color(0xFF1A2E1A),
            ),
            const SizedBox(height: 12),
            SocialLinkField(
              icon: Icons.work_outline,
              iconColor: const Color(0xFF0A66C2),
              controller: _linkedinController,
              backgroundColor: const Color(0xFF0A1929),
            ),
            const SizedBox(height: 12),
            SocialLinkField(
              icon: Icons.tag,
              iconColor: const Color(0xFF1DA1F2),
              controller: _twitterController,
              backgroundColor: const Color(0xFF0A1F2E),
            ),
            const SizedBox(height: 12),
            SocialLinkField(
              icon: Icons.camera_alt_outlined,
              iconColor: const Color(0xFFE4405F),
              controller: _instagramController,
              backgroundColor: const Color(0xFF2E0A1A),
            ),
            const SizedBox(height: 12),
            SocialLinkField(
              icon: Icons.link,
              iconColor: const Color(0xFF6B7280),
              controller: _portfolioController,
              backgroundColor: const Color(0xFF1A1A1A),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A1F0A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF6B5A2E), width: 1),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: Color(0xFFFFB020),
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You can always update your profile later',
                      style: TextStyle(color: Color(0xFFFFB020), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle profile completion
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Complete Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool required = false,
    int maxLines = 1,
    int? maxLength,
    String? hintText,
    String? helperText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (required)
              const Text(
                ' *',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white38),
            helperText: helperText,
            helperStyle: const TextStyle(color: Colors.white38, fontSize: 12),
            filled: true,
            fillColor: const Color(0xFF1A1A1A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            counterStyle: const TextStyle(color: Colors.white38),
          ),
        ),
      ],
    );
  }
}
