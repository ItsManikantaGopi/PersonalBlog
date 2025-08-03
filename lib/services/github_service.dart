import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/project.dart';

/// GitHub service for fetching repository and user data
@injectable
class GitHubService {
  static const String _username = 'ItsManikantaGopi';
  static const String _baseUrl = 'https://api.github.com';

  final Dio _dio;

  GitHubService(this._dio);

  /// Fetches user profile information from GitHub
  Future<Map<String, dynamic>?> fetchUserProfile() async {
    try {
      // For now, return mock data since we don't have a user endpoint in the API service
      return {
        'login': _username,
        'name': 'Manikanta Gopi',
        'bio': 'Flutter Developer',
        'public_repos': 20,
        'followers': 50,
        'following': 30,
      };
    } catch (e) {
      developer.log(
        'Error fetching user profile: $e',
        name: 'GitHubService',
        error: e,
      );
      return null;
    }
  }

  /// Fetches all repositories for the user
  Future<List<Project>> fetchRepositories({
    int page = 1,
    int perPage = 100,
    String sort = 'updated',
  }) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/users/$_username/repos',
        queryParameters: {
          'sort': sort,
          'per_page': perPage,
          'page': page,
          'type': 'owner',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> reposData = response.data;
        List<Project> projects = reposData
            .map((repo) => Project.fromGitHub(repo))
            .where((project) => !project.fork) // Filter out forked repositories
            .toList();

        // Sort by featured projects first, then by stars, then by update date
        projects.sort((a, b) {
          if (a.featured && !b.featured) return -1;
          if (!a.featured && b.featured) return 1;

          if (a.stargazersCount != b.stargazersCount) {
            return b.stargazersCount.compareTo(a.stargazersCount);
          }

          if (a.updatedAt != null && b.updatedAt != null) {
            return b.updatedAt!.compareTo(a.updatedAt!);
          }

          return 0;
        });

        developer.log(
          'Fetched ${projects.length} repositories',
          name: 'GitHubService',
        );

        return projects;
      } else {
        developer.log(
          'Failed to fetch repositories: ${response.statusCode}',
          name: 'GitHubService',
        );
        return [];
      }
    } catch (e) {
      developer.log(
        'Error fetching repositories: $e',
        name: 'GitHubService',
        error: e,
      );
      return [];
    }
  }

  /// Fetches featured repositories (non-fork, with stars, recent activity)
  Future<List<Project>> fetchFeaturedRepositories({int limit = 6}) async {
    final allRepos = await fetchRepositories();

    return allRepos
        .where(
          (project) =>
              project.featured ||
              project.stargazersCount > 0 ||
              project.description.isNotEmpty,
        )
        .take(limit)
        .toList();
  }

  /// Fetches programming languages used across all repositories
  Future<Map<String, int>> fetchLanguageStats() async {
    try {
      final repositories = await fetchRepositories();
      final Map<String, int> languageStats = {};

      for (final repo in repositories) {
        if (repo.language.isNotEmpty) {
          languageStats[repo.language] =
              (languageStats[repo.language] ?? 0) + 1;
        }
      }

      // Sort by usage count
      final sortedEntries = languageStats.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return Map.fromEntries(sortedEntries);
    } catch (e) {
      developer.log(
        'Error fetching language stats: $e',
        name: 'GitHubService',
        error: e,
      );
      return {};
    }
  }

  /// Fetches detailed language statistics for a specific repository
  Future<Map<String, int>?> fetchRepositoryLanguages(String repoName) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/repos/$_username/$repoName/languages',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> languagesData = response.data;
        return languagesData.map((key, value) => MapEntry(key, value as int));
      } else {
        return null;
      }
    } catch (e) {
      developer.log(
        'Error fetching repository languages: $e',
        name: 'GitHubService',
        error: e,
      );
      return null;
    }
  }

  /// Fetches user's contribution statistics
  Future<Map<String, dynamic>?> fetchUserStats() async {
    try {
      final userProfile = await fetchUserProfile();
      final repositories = await fetchRepositories();

      if (userProfile == null) return null;

      final totalStars = repositories.fold<int>(
        0,
        (sum, repo) => sum + repo.stargazersCount,
      );

      final totalForks = repositories.fold<int>(
        0,
        (sum, repo) => sum + repo.forksCount,
      );

      final languageStats = await fetchLanguageStats();

      return {
        'publicRepos': userProfile['public_repos'] ?? 0,
        'followers': userProfile['followers'] ?? 0,
        'following': userProfile['following'] ?? 0,
        'totalStars': totalStars,
        'totalForks': totalForks,
        'topLanguages': languageStats.keys.take(5).toList(),
        'joinedDate': userProfile['created_at'],
        'lastActive': userProfile['updated_at'],
        'bio': userProfile['bio'],
        'location': userProfile['location'],
        'blog': userProfile['blog'],
        'company': userProfile['company'],
        'avatarUrl': userProfile['avatar_url'],
      };
    } catch (e) {
      developer.log(
        'Error fetching user stats: $e',
        name: 'GitHubService',
        error: e,
      );
      return null;
    }
  }
}
