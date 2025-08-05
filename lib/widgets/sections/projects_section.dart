import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/project.dart';
import '../../services/github_service.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import '../common/project_card.dart';
import '../../core/di/injection.dart';

/// Projects showcase section with GitHub integration
class ProjectsSection extends StatefulWidget {
  final String? filterTechnology;

  const ProjectsSection({super.key, this.filterTechnology});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late final GitHubService _githubService;
  List<Project> _projects = [];
  List<Project> _filteredProjects = [];
  bool _isLoading = true;
  String? _error;
  String? _selectedFilter;
  Set<String> _availableTechnologies = {};

  @override
  void initState() {
    super.initState();
    _githubService = getIt<GitHubService>();
    _selectedFilter = widget.filterTechnology;
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final projects = await _githubService.fetchRepositories();

      // Extract available technologies
      final technologies = <String>{};
      for (final project in projects) {
        technologies.addAll(project.techStack);
        if (project.language.isNotEmpty) {
          technologies.add(project.language);
        }
      }

      setState(() {
        _projects = projects;
        _availableTechnologies = technologies;
        _isLoading = false;
        _filterProjects();
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load projects: $e';
        _isLoading = false;
      });
    }
  }

  void _filterProjects() {
    if (_selectedFilter == null || _selectedFilter!.isEmpty) {
      _filteredProjects = List.from(_projects);
    } else {
      _filteredProjects = _projects.where((project) {
        return project.techStack.contains(_selectedFilter) ||
            project.language.toLowerCase() == _selectedFilter!.toLowerCase();
      }).toList();
    }
  }

  void _setFilter(String? filter) {
    setState(() {
      _selectedFilter = filter;
      _filterProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context),
          const SizedBox(height: AppConstants.spaceXL),
          _buildFilterChips(context),
          const SizedBox(height: AppConstants.spaceLG),
          _buildProjectsGrid(context),
        ],
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Projects',
          style: GoogleFonts.inter(
            fontSize: context.responsiveValue(
              mobile: AppConstants.fontSizeH2,
              tablet: AppConstants.fontSizeH1,
              desktop: AppConstants.fontSizeH1,
            ),
            fontWeight: FontWeight.w700,
            color: AppConstants.primaryText,
          ),
        ),
        const SizedBox(height: AppConstants.spaceMD),
        Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(
              mobile: double.infinity,
              tablet: 600.0,
              desktop: 700.0,
            ),
          ),
          child: Text(
            'A collection of projects that showcase my skills in Flutter development, '
            'mobile applications, and web technologies. Each project demonstrates '
            'different aspects of modern software development.',
            style: GoogleFonts.inter(
              fontSize: context.responsiveValue(
                mobile: AppConstants.fontSizeBody,
                tablet: AppConstants.fontSizeBodyLarge,
                desktop: AppConstants.fontSizeBodyLarge,
              ),
              fontWeight: FontWeight.w400,
              color: AppConstants.secondaryText,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  /// Build filter chips
  Widget _buildFilterChips(BuildContext context) {
    if (_availableTechnologies.isEmpty) {
      return const SizedBox.shrink();
    }

    final technologies = _availableTechnologies.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter by Technology',
          style: GoogleFonts.inter(
            fontSize: AppConstants.fontSizeBodyLarge,
            fontWeight: FontWeight.w600,
            color: AppConstants.primaryText,
          ),
        ),
        const SizedBox(height: AppConstants.spaceMD),
        Wrap(
          spacing: AppConstants.spaceSM,
          runSpacing: AppConstants.spaceSM,
          children: [
            // All filter chip
            FilterChip(
              label: const Text('All'),
              selected: _selectedFilter == null,
              onSelected: (selected) => _setFilter(null),
              backgroundColor: AppConstants.cardBackground,
              selectedColor: AppConstants.accentColor.withValues(alpha: 0.2),
              checkmarkColor: AppConstants.accentColor,
              labelStyle: GoogleFonts.inter(
                color: _selectedFilter == null
                    ? AppConstants.accentColor
                    : AppConstants.primaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Technology filter chips
            ...technologies.map(
              (tech) => FilterChip(
                label: Text(tech),
                selected: _selectedFilter == tech,
                onSelected: (selected) => _setFilter(selected ? tech : null),
                backgroundColor: AppConstants.cardBackground,
                selectedColor: AppConstants.accentColor.withValues(alpha: 0.2),
                checkmarkColor: AppConstants.accentColor,
                labelStyle: GoogleFonts.inter(
                  color: _selectedFilter == tech
                      ? AppConstants.accentColor
                      : AppConstants.primaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build projects grid
  Widget _buildProjectsGrid(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingState(context);
    }

    if (_error != null) {
      return _buildErrorState(context);
    }

    if (_filteredProjects.isEmpty) {
      return _buildEmptyState(context);
    }

    return AnimationLimiter(
      child: ResponsiveGrid(
        mobileColumns: 1,
        tabletColumns: 2,
        desktopColumns: 3,
        spacing: AppConstants.gridGap,
        children: _filteredProjects.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;

          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 600),
            columnCount: context.responsiveGridColumns,
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: ProjectCard(
                  project: project,
                  onTap: () => _openProject(project),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Build loading state
  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppConstants.accentColor),
          ),
          const SizedBox(height: AppConstants.spaceMD),
          Text(
            'Loading projects...',
            style: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeBody,
              color: AppConstants.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  /// Build error state
  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: AppConstants.iconSizeXL,
            color: AppConstants.errorColor,
          ),
          const SizedBox(height: AppConstants.spaceMD),
          Text(
            'Failed to Load Projects',
            style: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeH4,
              fontWeight: FontWeight.w600,
              color: AppConstants.primaryText,
            ),
          ),
          const SizedBox(height: AppConstants.spaceSM),
          Text(
            _error ?? 'An unexpected error occurred',
            style: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeBody,
              color: AppConstants.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spaceLG),
          ElevatedButton.icon(
            onPressed: _loadProjects,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// Build empty state
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: AppConstants.iconSizeXL,
            color: AppConstants.mutedText,
          ),
          const SizedBox(height: AppConstants.spaceMD),
          Text(
            'No Projects Found',
            style: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeH4,
              fontWeight: FontWeight.w600,
              color: AppConstants.primaryText,
            ),
          ),
          const SizedBox(height: AppConstants.spaceSM),
          Text(
            _selectedFilter != null
                ? 'No projects found for "$_selectedFilter"'
                : 'No projects available at the moment',
            style: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeBody,
              color: AppConstants.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
          if (_selectedFilter != null) ...[
            const SizedBox(height: AppConstants.spaceLG),
            TextButton(
              onPressed: () => _setFilter(null),
              child: const Text('Show All Projects'),
            ),
          ],
        ],
      ),
    );
  }

  /// Open project in browser
  Future<void> _openProject(Project project) async {
    final url = project.homepage?.isNotEmpty == true
        ? project.homepage!
        : project.htmlUrl;

    if (url != null) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }
}
