import 'package:gitgossip/features/userProfile/models/social_links_model.dart';

class UserModel {
  /// MongoDB document ID (_id)
  final String id;

  /// Firebase Authentication UID
  final String firebaseUid;

  final String? fullName;
  final String? username;
  final String email;

  /// Stored as String to support country codes (+91, etc.)
  final String? userPhoneNumber;
  final String? userBio;

  final String? profilePic;
  final List<String>? techStack;

  final SocialLinks? socialLinks;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.firebaseUid,
    this.fullName,
    this.username,
    required this.email,
    this.userPhoneNumber,
    this.userBio,
    this.profilePic,
    this.techStack,
    this.socialLinks,

    this.createdAt,
    this.updatedAt,
  });

  // ---------- FROM JSON ----------
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firebaseUid: json['firebaseUid'],
      fullName: json['fullName'],
      username: json['username'],
      email: json['email'],
      userPhoneNumber: json['userPhoneNumber'],
      userBio: json["userBio"],
      profilePic: json['profilePic'],
      techStack: json['techStack'] != null
          ? List<String>.from(json['techStack'])
          : [],
      socialLinks: json['socialLinks'] != null
          ? SocialLinks.fromJson(json['socialLinks'])
          : null,

      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  // ---------- TO JSON ----------
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "firebaseUid": firebaseUid,
      "fullName": fullName,
      "username": username,
      "email": email,
      "userPhoneNumber": userPhoneNumber,
      "userBio": userBio,
      "profilePic": profilePic,
      'techStack': techStack,
      "socialLinks": socialLinks?.toJson(),
    };
  }

  // ---------- COPY WITH ----------
  UserModel copyWith({
    String? id,
    String? firebaseUid,
    String? fullName,
    String? username,
    String? email,
    String? userPhoneNumber,
    String? userBio,
    String? profilePic,
    List<String>? techStack, // ✅ Corrected
    SocialLinks? socialLinks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
      userBio: userBio ?? this.userBio,
      profilePic: profilePic ?? this.profilePic,
      techStack: techStack ?? this.techStack,
      socialLinks: socialLinks ?? this.socialLinks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
