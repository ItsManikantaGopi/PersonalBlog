enum SkillCategory {
  mobileDevelopment,
  webDevelopment,
  backend,
  tools,
  languages,
  frameworks,
  databases,
  cloud,
}

extension SkillCategoryExtension on SkillCategory {
  String get displayName {
    switch (this) {
      case SkillCategory.mobileDevelopment:
        return 'Mobile Development';
      case SkillCategory.webDevelopment:
        return 'Web Development';
      case SkillCategory.backend:
        return 'Backend';
      case SkillCategory.tools:
        return 'Tools & IDEs';
      case SkillCategory.languages:
        return 'Programming Languages';
      case SkillCategory.frameworks:
        return 'Frameworks';
      case SkillCategory.databases:
        return 'Databases';
      case SkillCategory.cloud:
        return 'Cloud & DevOps';
    }
  }

  String get icon {
    switch (this) {
      case SkillCategory.mobileDevelopment:
        return '📱';
      case SkillCategory.webDevelopment:
        return '🌐';
      case SkillCategory.backend:
        return '⚙️';
      case SkillCategory.tools:
        return '🛠️';
      case SkillCategory.languages:
        return '💻';
      case SkillCategory.frameworks:
        return '🏗️';
      case SkillCategory.databases:
        return '🗄️';
      case SkillCategory.cloud:
        return '☁️';
    }
  }
}

enum SkillLevel {
  beginner,
  intermediate,
  advanced,
  expert,
}

extension SkillLevelExtension on SkillLevel {
  String get displayName {
    switch (this) {
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
      case SkillLevel.expert:
        return 'Expert';
    }
  }

  double get percentage {
    switch (this) {
      case SkillLevel.beginner:
        return 0.25;
      case SkillLevel.intermediate:
        return 0.5;
      case SkillLevel.advanced:
        return 0.75;
      case SkillLevel.expert:
        return 1.0;
    }
  }

  int get stars {
    switch (this) {
      case SkillLevel.beginner:
        return 1;
      case SkillLevel.intermediate:
        return 2;
      case SkillLevel.advanced:
        return 3;
      case SkillLevel.expert:
        return 4;
    }
  }
}

class Skill {
  final String id;
  final String name;
  final SkillCategory category;
  final SkillLevel level;
  final String? iconUrl;
  final String? description;
  final List<String> relatedProjects;
  final int yearsOfExperience;
  final bool featured;

  Skill({
    required this.id,
    required this.name,
    required this.category,
    required this.level,
    this.iconUrl,
    this.description,
    this.relatedProjects = const [],
    this.yearsOfExperience = 0,
    this.featured = false,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: SkillCategory.values.firstWhere(
        (e) => e.toString() == 'SkillCategory.${json['category']}',
        orElse: () => SkillCategory.tools,
      ),
      level: SkillLevel.values.firstWhere(
        (e) => e.toString() == 'SkillLevel.${json['level']}',
        orElse: () => SkillLevel.intermediate,
      ),
      iconUrl: json['iconUrl'],
      description: json['description'],
      relatedProjects: List<String>.from(json['relatedProjects'] ?? []),
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      featured: json['featured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category.toString().split('.').last,
      'level': level.toString().split('.').last,
      'iconUrl': iconUrl,
      'description': description,
      'relatedProjects': relatedProjects,
      'yearsOfExperience': yearsOfExperience,
      'featured': featured,
    };
  }

  Skill copyWith({
    String? id,
    String? name,
    SkillCategory? category,
    SkillLevel? level,
    String? iconUrl,
    String? description,
    List<String>? relatedProjects,
    int? yearsOfExperience,
    bool? featured,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      level: level ?? this.level,
      iconUrl: iconUrl ?? this.iconUrl,
      description: description ?? this.description,
      relatedProjects: relatedProjects ?? this.relatedProjects,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      featured: featured ?? this.featured,
    );
  }

  @override
  String toString() {
    return 'Skill(name: $name, category: ${category.displayName}, level: ${level.displayName})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Skill && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
