import '../models/skill.dart';
import '../models/social_link.dart';

/// Portfolio data containing skills and social links
class PortfolioData {
  // Private constructor to prevent instantiation
  PortfolioData._();

  /// List of skills organized by category
  static final List<Skill> skills = [
    // Mobile Development
    Skill(
      id: 'flutter',
      name: 'Flutter',
      category: SkillCategory.mobileDevelopment,
      level: SkillLevel.expert,
      description: 'Cross-platform mobile app development framework',
      yearsOfExperience: 3,
      featured: true,
    ),
    Skill(
      id: 'dart',
      name: 'Dart',
      category: SkillCategory.languages,
      level: SkillLevel.expert,
      description: 'Programming language optimized for building mobile, desktop, server, and web applications',
      yearsOfExperience: 3,
      featured: true,
    ),
    Skill(
      id: 'android',
      name: 'Android Development',
      category: SkillCategory.mobileDevelopment,
      level: SkillLevel.advanced,
      description: 'Native Android app development',
      yearsOfExperience: 2,
    ),
    Skill(
      id: 'ios',
      name: 'iOS Development',
      category: SkillCategory.mobileDevelopment,
      level: SkillLevel.intermediate,
      description: 'iOS app development with Flutter',
      yearsOfExperience: 2,
    ),

    // Web Development
    Skill(
      id: 'flutter_web',
      name: 'Flutter Web',
      category: SkillCategory.webDevelopment,
      level: SkillLevel.advanced,
      description: 'Building responsive web applications with Flutter',
      yearsOfExperience: 2,
      featured: true,
    ),
    Skill(
      id: 'html',
      name: 'HTML5',
      category: SkillCategory.webDevelopment,
      level: SkillLevel.advanced,
      description: 'Modern HTML markup and semantic web development',
      yearsOfExperience: 4,
    ),
    Skill(
      id: 'css',
      name: 'CSS3',
      category: SkillCategory.webDevelopment,
      level: SkillLevel.advanced,
      description: 'Styling, animations, and responsive design',
      yearsOfExperience: 4,
    ),
    Skill(
      id: 'javascript',
      name: 'JavaScript',
      category: SkillCategory.languages,
      level: SkillLevel.intermediate,
      description: 'Modern JavaScript ES6+ for web development',
      yearsOfExperience: 3,
    ),

    // Backend & APIs
    Skill(
      id: 'firebase',
      name: 'Firebase',
      category: SkillCategory.backend,
      level: SkillLevel.advanced,
      description: 'Backend-as-a-Service platform for mobile and web apps',
      yearsOfExperience: 3,
      featured: true,
    ),
    Skill(
      id: 'nodejs',
      name: 'Node.js',
      category: SkillCategory.backend,
      level: SkillLevel.intermediate,
      description: 'Server-side JavaScript runtime',
      yearsOfExperience: 2,
    ),
    Skill(
      id: 'rest_api',
      name: 'REST APIs',
      category: SkillCategory.backend,
      level: SkillLevel.advanced,
      description: 'RESTful API design and integration',
      yearsOfExperience: 3,
    ),

    // Tools & IDEs
    Skill(
      id: 'git',
      name: 'Git',
      category: SkillCategory.tools,
      level: SkillLevel.advanced,
      description: 'Version control and collaborative development',
      yearsOfExperience: 4,
    ),
    Skill(
      id: 'vscode',
      name: 'VS Code',
      category: SkillCategory.tools,
      level: SkillLevel.expert,
      description: 'Primary development environment',
      yearsOfExperience: 4,
      featured: true,
    ),
    Skill(
      id: 'android_studio',
      name: 'Android Studio',
      category: SkillCategory.tools,
      level: SkillLevel.advanced,
      description: 'Android development IDE',
      yearsOfExperience: 3,
    ),
    Skill(
      id: 'figma',
      name: 'Figma',
      category: SkillCategory.tools,
      level: SkillLevel.intermediate,
      description: 'UI/UX design and prototyping',
      yearsOfExperience: 2,
    ),

    // Databases
    Skill(
      id: 'firestore',
      name: 'Firestore',
      category: SkillCategory.databases,
      level: SkillLevel.advanced,
      description: 'NoSQL document database',
      yearsOfExperience: 3,
    ),
    Skill(
      id: 'sqlite',
      name: 'SQLite',
      category: SkillCategory.databases,
      level: SkillLevel.intermediate,
      description: 'Local database for mobile apps',
      yearsOfExperience: 2,
    ),

    // Programming Languages
    Skill(
      id: 'python',
      name: 'Python',
      category: SkillCategory.languages,
      level: SkillLevel.intermediate,
      description: 'General-purpose programming language',
      yearsOfExperience: 2,
    ),
    Skill(
      id: 'java',
      name: 'Java',
      category: SkillCategory.languages,
      level: SkillLevel.intermediate,
      description: 'Object-oriented programming language',
      yearsOfExperience: 2,
    ),

    // Cloud & DevOps
    Skill(
      id: 'github_actions',
      name: 'GitHub Actions',
      category: SkillCategory.cloud,
      level: SkillLevel.intermediate,
      description: 'CI/CD automation and deployment',
      yearsOfExperience: 1,
    ),
  ];

  /// List of social links
  static final List<SocialLink> socialLinks = [
    SocialLink.create(
      platform: SocialPlatform.github,
      username: 'ItsManikantaGopi',
      featured: true,
      order: 1,
    ),
    SocialLink.create(
      platform: SocialPlatform.linkedin,
      username: 'manikanta-gopi', // This should be updated with actual LinkedIn username
      featured: true,
      order: 2,
    ),
    SocialLink.create(
      platform: SocialPlatform.email,
      username: 'manikanta.gopi@example.com', // This should be updated with actual email
      customUrl: 'mailto:manikanta.gopi@example.com',
      featured: true,
      order: 3,
    ),
    SocialLink.create(
      platform: SocialPlatform.twitter,
      username: 'ManikantaGopi', // This should be updated with actual Twitter handle
      featured: false,
      order: 4,
    ),
  ];

  /// Get skills by category
  static List<Skill> getSkillsByCategory(SkillCategory category) {
    return skills.where((skill) => skill.category == category).toList();
  }

  /// Get featured skills
  static List<Skill> getFeaturedSkills() {
    return skills.where((skill) => skill.featured).toList();
  }

  /// Get skills by level
  static List<Skill> getSkillsByLevel(SkillLevel level) {
    return skills.where((skill) => skill.level == level).toList();
  }

  /// Get featured social links
  static List<SocialLink> getFeaturedSocialLinks() {
    return socialLinks.where((link) => link.featured).toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  /// Get all social links sorted by order
  static List<SocialLink> getAllSocialLinks() {
    return List.from(socialLinks)..sort((a, b) => a.order.compareTo(b.order));
  }

  /// Get skills grouped by category
  static Map<SkillCategory, List<Skill>> getSkillsGroupedByCategory() {
    final Map<SkillCategory, List<Skill>> grouped = {};
    
    for (final skill in skills) {
      if (!grouped.containsKey(skill.category)) {
        grouped[skill.category] = [];
      }
      grouped[skill.category]!.add(skill);
    }
    
    // Sort skills within each category by level and name
    for (final category in grouped.keys) {
      grouped[category]!.sort((a, b) {
        // First sort by featured status
        if (a.featured && !b.featured) return -1;
        if (!a.featured && b.featured) return 1;
        
        // Then by level (expert first)
        final levelComparison = b.level.index.compareTo(a.level.index);
        if (levelComparison != 0) return levelComparison;
        
        // Finally by name
        return a.name.compareTo(b.name);
      });
    }
    
    return grouped;
  }

  /// Get technology statistics
  static Map<String, dynamic> getTechnologyStats() {
    final totalSkills = skills.length;
    final expertSkills = skills.where((s) => s.level == SkillLevel.expert).length;
    final advancedSkills = skills.where((s) => s.level == SkillLevel.advanced).length;
    final featuredSkills = skills.where((s) => s.featured).length;
    
    final categoryCounts = <SkillCategory, int>{};
    for (final skill in skills) {
      categoryCounts[skill.category] = (categoryCounts[skill.category] ?? 0) + 1;
    }
    
    return {
      'totalSkills': totalSkills,
      'expertSkills': expertSkills,
      'advancedSkills': advancedSkills,
      'featuredSkills': featuredSkills,
      'categoryCounts': categoryCounts,
      'averageExperience': skills.fold<double>(
        0.0, 
        (sum, skill) => sum + skill.yearsOfExperience,
      ) / totalSkills,
    };
  }
}
