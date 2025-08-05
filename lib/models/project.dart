class Project {
  final String id;
  final String name;
  final String description;
  final String? htmlUrl;
  final String? homepage;
  final List<String> topics;
  final String language;
  final int stargazersCount;
  final int forksCount;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final bool fork;
  final String? imageUrl;
  final List<String> techStack;
  final bool featured;

  Project({
    required this.id,
    required this.name,
    required this.description,
    this.htmlUrl,
    this.homepage,
    this.topics = const [],
    this.language = '',
    this.stargazersCount = 0,
    this.forksCount = 0,
    this.updatedAt,
    this.createdAt,
    this.fork = false,
    this.imageUrl,
    this.techStack = const [],
    this.featured = false,
  });

  factory Project.fromGitHub(Map<String, dynamic> json) {
    return Project(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? 'No description available',
      htmlUrl: json['html_url'],
      homepage: json['homepage'],
      topics: List<String>.from(json['topics'] ?? []),
      language: json['language'] ?? '',
      stargazersCount: json['stargazers_count'] ?? 0,
      forksCount: json['forks_count'] ?? 0,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
      fork: json['fork'] ?? false,
      techStack: _extractTechStack(json),
      featured: _isFeatured(json),
    );
  }

  static List<String> _extractTechStack(Map<String, dynamic> json) {
    List<String> stack = [];
    
    // Add primary language
    if (json['language'] != null && json['language'].isNotEmpty) {
      stack.add(json['language']);
    }
    
    // Add topics as tech stack
    if (json['topics'] != null) {
      stack.addAll(List<String>.from(json['topics']));
    }
    
    return stack;
  }

  static bool _isFeatured(Map<String, dynamic> json) {
    // Consider a project featured if it has:
    // - More than 0 stars
    // - Not a fork
    // - Has a description
    // - Recently updated (within last year)
    
    final stars = json['stargazers_count'] ?? 0;
    final isFork = json['fork'] ?? false;
    final hasDescription = json['description'] != null && 
                          json['description'].toString().isNotEmpty;
    
    DateTime? updatedAt;
    if (json['updated_at'] != null) {
      updatedAt = DateTime.parse(json['updated_at']);
    }
    
    final recentlyUpdated = updatedAt != null && 
        DateTime.now().difference(updatedAt).inDays < 365;
    
    return stars > 0 && !isFork && hasDescription && recentlyUpdated;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'htmlUrl': htmlUrl,
      'homepage': homepage,
      'topics': topics,
      'language': language,
      'stargazersCount': stargazersCount,
      'forksCount': forksCount,
      'updatedAt': updatedAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'fork': fork,
      'imageUrl': imageUrl,
      'techStack': techStack,
      'featured': featured,
    };
  }

  Project copyWith({
    String? id,
    String? name,
    String? description,
    String? htmlUrl,
    String? homepage,
    List<String>? topics,
    String? language,
    int? stargazersCount,
    int? forksCount,
    DateTime? updatedAt,
    DateTime? createdAt,
    bool? fork,
    String? imageUrl,
    List<String>? techStack,
    bool? featured,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      homepage: homepage ?? this.homepage,
      topics: topics ?? this.topics,
      language: language ?? this.language,
      stargazersCount: stargazersCount ?? this.stargazersCount,
      forksCount: forksCount ?? this.forksCount,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      fork: fork ?? this.fork,
      imageUrl: imageUrl ?? this.imageUrl,
      techStack: techStack ?? this.techStack,
      featured: featured ?? this.featured,
    );
  }

  @override
  String toString() {
    return 'Project(id: $id, name: $name, language: $language, stars: $stargazersCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Project && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
