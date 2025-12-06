class User {
  final String id; // maps to backend "_id"
  final String firebaseUid; // maps to backend "firebaseUid"
  final String? name;
  final String? email;
  final String? profilePic;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.firebaseUid,
    this.name,
    this.email,
    this.profilePic,
    this.createdAt,
    this.updatedAt,
  });

  // ------- FROM JSON -------
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'],
      firebaseUid: json['firebaseUid'],
      name: json['name'],
      email: json['email'],
      profilePic: json['profilePic'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  // ------- TO JSON -------
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "firebaseUid": firebaseUid,
      "name": name,
      "email": email,
      "profilePic": profilePic,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }

  // ------- COPY WITH -------
  User copyWith({
    String? id,
    String? firebaseUid,
    String? name,
    String? email,
    String? profilePic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
