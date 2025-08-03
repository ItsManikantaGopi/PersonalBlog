enum SocialPlatform {
  github,
  linkedin,
  twitter,
  email,
  website,
  instagram,
  youtube,
  medium,
  stackoverflow,
  discord,
}

extension SocialPlatformExtension on SocialPlatform {
  String get displayName {
    switch (this) {
      case SocialPlatform.github:
        return 'GitHub';
      case SocialPlatform.linkedin:
        return 'LinkedIn';
      case SocialPlatform.twitter:
        return 'Twitter';
      case SocialPlatform.email:
        return 'Email';
      case SocialPlatform.website:
        return 'Website';
      case SocialPlatform.instagram:
        return 'Instagram';
      case SocialPlatform.youtube:
        return 'YouTube';
      case SocialPlatform.medium:
        return 'Medium';
      case SocialPlatform.stackoverflow:
        return 'Stack Overflow';
      case SocialPlatform.discord:
        return 'Discord';
    }
  }

  String get icon {
    switch (this) {
      case SocialPlatform.github:
        return '🐙'; // Will be replaced with proper icons
      case SocialPlatform.linkedin:
        return '💼';
      case SocialPlatform.twitter:
        return '🐦';
      case SocialPlatform.email:
        return '📧';
      case SocialPlatform.website:
        return '🌐';
      case SocialPlatform.instagram:
        return '📷';
      case SocialPlatform.youtube:
        return '📺';
      case SocialPlatform.medium:
        return '📝';
      case SocialPlatform.stackoverflow:
        return '📚';
      case SocialPlatform.discord:
        return '💬';
    }
  }

  String get baseUrl {
    switch (this) {
      case SocialPlatform.github:
        return 'https://github.com/';
      case SocialPlatform.linkedin:
        return 'https://linkedin.com/in/';
      case SocialPlatform.twitter:
        return 'https://twitter.com/';
      case SocialPlatform.email:
        return 'mailto:';
      case SocialPlatform.website:
        return '';
      case SocialPlatform.instagram:
        return 'https://instagram.com/';
      case SocialPlatform.youtube:
        return 'https://youtube.com/';
      case SocialPlatform.medium:
        return 'https://medium.com/@';
      case SocialPlatform.stackoverflow:
        return 'https://stackoverflow.com/users/';
      case SocialPlatform.discord:
        return 'https://discord.com/users/';
    }
  }

  String get hoverColor {
    switch (this) {
      case SocialPlatform.github:
        return '#333333';
      case SocialPlatform.linkedin:
        return '#0077B5';
      case SocialPlatform.twitter:
        return '#1DA1F2';
      case SocialPlatform.email:
        return '#EA4335';
      case SocialPlatform.website:
        return '#00BCD4';
      case SocialPlatform.instagram:
        return '#E4405F';
      case SocialPlatform.youtube:
        return '#FF0000';
      case SocialPlatform.medium:
        return '#00AB6C';
      case SocialPlatform.stackoverflow:
        return '#F58025';
      case SocialPlatform.discord:
        return '#5865F2';
    }
  }
}

class SocialLink {
  final String id;
  final SocialPlatform platform;
  final String url;
  final String? username;
  final String? displayText;
  final bool featured;
  final int order;

  SocialLink({
    required this.id,
    required this.platform,
    required this.url,
    this.username,
    this.displayText,
    this.featured = false,
    this.order = 0,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) {
    return SocialLink(
      id: json['id'] ?? '',
      platform: SocialPlatform.values.firstWhere(
        (e) => e.toString() == 'SocialPlatform.${json['platform']}',
        orElse: () => SocialPlatform.website,
      ),
      url: json['url'] ?? '',
      username: json['username'],
      displayText: json['displayText'],
      featured: json['featured'] ?? false,
      order: json['order'] ?? 0,
    );
  }

  factory SocialLink.create({
    required SocialPlatform platform,
    required String username,
    String? customUrl,
    String? displayText,
    bool featured = false,
    int order = 0,
  }) {
    final url = customUrl ?? '${platform.baseUrl}$username';
    
    return SocialLink(
      id: '${platform.toString().split('.').last}_$username',
      platform: platform,
      url: url,
      username: username,
      displayText: displayText ?? platform.displayName,
      featured: featured,
      order: order,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platform': platform.toString().split('.').last,
      'url': url,
      'username': username,
      'displayText': displayText,
      'featured': featured,
      'order': order,
    };
  }

  SocialLink copyWith({
    String? id,
    SocialPlatform? platform,
    String? url,
    String? username,
    String? displayText,
    bool? featured,
    int? order,
  }) {
    return SocialLink(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      url: url ?? this.url,
      username: username ?? this.username,
      displayText: displayText ?? this.displayText,
      featured: featured ?? this.featured,
      order: order ?? this.order,
    );
  }

  @override
  String toString() {
    return 'SocialLink(platform: ${platform.displayName}, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SocialLink && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
