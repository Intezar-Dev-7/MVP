import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gitgossip/core/utils/validators.dart';
import 'package:gitgossip/core/widgets/custom_snack_bar.dart';
import 'package:gitgossip/features/authentication/services/google_auth_service.dart';
import 'package:gitgossip/features/userProfile/models/social_links_model.dart';
import 'package:gitgossip/features/userProfile/services/editProfileServices.dart';
import 'package:gitgossip/features/userProfile/widgets/edit_profile_customtexfield.dart';
import 'package:gitgossip/features/userProfile/widgets/logout_button.dart';
import 'package:gitgossip/features/userProfile/widgets/skill_chip.dart';
import 'package:gitgossip/features/userProfile/widgets/social_linked_field.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _firebaseProfilePic;
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _customSkillController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _portfolioController = TextEditingController();

  final GoogleAuthServices _googleAuthServices = GoogleAuthServices();
  final Editprofileservices _editProfileServices = Editprofileservices();
  final List<String> _selectedSkills = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
    _customSkillController.dispose();
    _githubController.dispose();
    _linkedinController.dispose();
    _instagramController.dispose();
    _portfolioController.dispose();
    super.dispose();
  }

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

  XFile? _pickedProfileImage;

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (image != null) {
      setState(() {
        _pickedProfileImage = image;
      });
    }
  }

  // Function to add user details
  Future<void> updateUserDetails() async {
    try {
      await _editProfileServices.editUserProfile(
        fullName: _fullNameController.text.trim(),
        username: _usernameController.text.trim(),
        userPhoneNumber: _phoneController.text.trim(),
        userBio: _bioController.text.trim(),
        profilePic: _pickedProfileImage,
        techStack: _selectedSkills,
        socialLinks: SocialLinks(
          github: _githubController.text.trim(),
          instagram: _instagramController.text.trim(),
          linkedin: _linkedinController.text.trim(),
          portfolio: _portfolioController.text.trim(),
        ),
      );

      if (!mounted) return;

      showAnimatedSnackBar(context, "Profile updated successfully");
    } catch (e) {
      if (!mounted) return;

      showAnimatedSnackBar(context, e.toString());
    }
  }

  // Fetching user from the backend to load  name , email , and profile pic of the user
  @override
  void initState() {
    super.initState();

    _loadUserFromBackend();
  }

  Future<void> _loadUserFromBackend() async {
    try {
      final user = await _editProfileServices.getMyProfileDetails();

      if (!mounted) return; // 🔑 THIS IS NON-NEGOTIABLE
      setState(() {
        _fullNameController.text = user.fullName;
        _emailController.text = user.email;
        _usernameController.text = user.username ?? "";
        _phoneController.text = user.userPhoneNumber ?? "";
        _bioController.text = user.userBio ?? "";

        _selectedSkills.clear();
        _selectedSkills.addAll(user.techStack ?? []);

        _firebaseProfilePic = user.profilePic; // from DB

        _githubController.text = user.socialLinks?.github ?? "";
        _instagramController.text = user.socialLinks?.instagram ?? "";
        _linkedinController.text = user.socialLinks?.linkedin ?? "";
        _portfolioController.text = user.socialLinks?.portfolio ?? "";
      });
    } catch (e) {
      if (!mounted) return;
      showAnimatedSnackBar(context, e.toString());
    }
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set up your developer profile to get started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              // profile avatar section
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: _pickProfileImage,
                      child: Container(
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
                        child: _pickedProfileImage != null
                            ? ClipOval(
                                child: Image.file(
                                  File(_pickedProfileImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : _firebaseProfilePic != null
                            ? ClipOval(
                                child: Image.network(
                                  _firebaseProfilePic!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.person, size: 50),
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
              const SizedBox(height: 20),
              EditProfileCustomtexfield(
                controller: _fullNameController,
                required: true,
                hintText: "Full Name",
                validator: Validators.validateFullName,
              ),
              const SizedBox(height: 20),
              EditProfileCustomtexfield(
                controller: _usernameController,
                required: true,
                hintText: "Username",
                helperText: 'Only lowercase letters, numbers, and underscores',
                validator: Validators.validateUsername,
              ),
              const SizedBox(height: 32),
              EditProfileCustomtexfield(
                controller: _emailController,
                hintText: "Email",
                required: true,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 20),
              EditProfileCustomtexfield(
                hintText: "Phone Number",

                controller: _phoneController,
                required: true,
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone, // ✅ HERE
              ),
              const SizedBox(height: 20),
              EditProfileCustomtexfield(
                controller: _bioController,
                maxLines: 5,
                maxLength: 160,

                hintText:
                    'Tell us about yourself... (e.g., Full-stack developer passionate about open source)',
                required: true,
                validator: Validators.validateBio,
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
                icon: Icons.code, // GitHub icon
                iconColor: const Color(0xFF4CAF50),
                controller: _githubController,
                hintText: 'GitHub URL',
                keyboardType: TextInputType.url,
                backgroundColor: const Color(0xFF1A2E1A),
                validator: Validators.validateUrl,
              ),
              const SizedBox(height: 12),

              SocialLinkField(
                icon: Icons.camera_alt_outlined, // Instagram icon
                iconColor: const Color(0xFFE4405F),
                controller: _instagramController,
                hintText: 'Instagram URL',
                keyboardType: TextInputType.url,
                backgroundColor: const Color(0xFF2E0A1A),
                validator: Validators.validateUrl,
              ),
              const SizedBox(height: 12),

              SocialLinkField(
                icon: Icons.work_outline, // LinkedIn icon
                iconColor: const Color(0xFF0A66C2),
                controller: _linkedinController,
                hintText: 'LinkedIn URL',
                keyboardType: TextInputType.url,
                backgroundColor: const Color(0xFF0A1929),
                validator: Validators.validateUrl,
              ),
              const SizedBox(height: 12),

              SocialLinkField(
                icon: Icons.link, // Portfolio link
                iconColor: const Color(0xFF6B7280),
                controller: _portfolioController,
                hintText: 'Portfolio URL',
                keyboardType: TextInputType.url,
                backgroundColor: const Color(0xFF1A1A1A),
                validator: Validators.validateUrl,
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
                        style: TextStyle(
                          color: Color(0xFFFFB020),
                          fontSize: 14,
                        ),
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
                    if (!_formKey.currentState!.validate()) {
                      return; // ❌ STOP here
                    }

                    updateUserDetails(); // ✅ only valid data reaches backend
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              logoutButton(googleAuthServices: _googleAuthServices),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
