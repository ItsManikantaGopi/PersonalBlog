import 'package:injectable/injectable.dart';
import '../../models/project.dart';
import '../../services/github_service.dart';

/// Repository layer following Jetpack architecture pattern
/// Handles data operations and provides a clean API for the UI layer
@injectable
class PortfolioRepository {
  final GitHubService _githubService;

  PortfolioRepository(this._githubService);

  /// Fetches all projects from GitHub
  Future<List<Project>> getProjects() async {
    try {
      return await _githubService.fetchRepositories();
    } catch (e) {
      // Log error and return empty list
      return [];
    }
  }

  /// Fetches featured projects only
  Future<List<Project>> getFeaturedProjects({int limit = 6}) async {
    try {
      return await _githubService.fetchFeaturedRepositories(limit: limit);
    } catch (e) {
      // Log error and return empty list
      return [];
    }
  }

  /// Fetches user profile information
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      return await _githubService.fetchUserProfile();
    } catch (e) {
      // Log error and return null
      return null;
    }
  }

  /// Fetches user statistics
  Future<Map<String, dynamic>?> getUserStats() async {
    try {
      return await _githubService.fetchUserStats();
    } catch (e) {
      // Log error and return null
      return null;
    }
  }

  /// Fetches repository languages for a specific project
  Future<Map<String, int>?> getProjectLanguages(String repoName) async {
    try {
      return await _githubService.fetchRepositoryLanguages(repoName);
    } catch (e) {
      // Log error and return null
      return null;
    }
  }
}
