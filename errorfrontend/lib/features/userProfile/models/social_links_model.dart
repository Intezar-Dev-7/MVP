class SocialLinks {
  final String? instagram;
  final String? github;
  final String? linkedin;
  final String? portfolio;

  SocialLinks({this.instagram, this.github, this.linkedin, this.portfolio});

  factory SocialLinks.fromJson(Map<String, dynamic>? json) {
    if (json == null) return SocialLinks();

    return SocialLinks(
      instagram: json['instagram'],
      github: json['github'],
      linkedin: json['linkedin'],
      portfolio: json['portfolio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instagram': instagram,
      'github': github,
      'linkedin': linkedin,
      'portfolio': portfolio,
    };
  }

  SocialLinks copyWith({
    String? instagram,
    String? github,
    String? linkedin,
    String? portfolio,
  }) {
    return SocialLinks(
      instagram: instagram ?? this.instagram,
      github: github ?? this.github,
      linkedin: linkedin ?? this.linkedin,
      portfolio: portfolio ?? this.portfolio,
    );
  }
}
