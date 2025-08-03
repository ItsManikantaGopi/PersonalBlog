import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/project.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';

/// Project card widget with hover effects and interactive elements
class ProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: AppConstants.animationNormal,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHover(true),
            onExit: (_) => _onHover(false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                height: context.responsiveValue(
                  mobile: 320.0,
                  tablet: 340.0,
                  desktop: 360.0,
                ),
                decoration: BoxDecoration(
                  color: AppConstants.cardBackground,
                  borderRadius: BorderRadius.circular(AppConstants.radiusLG),
                  border: Border.all(
                    color: _isHovered
                        ? AppConstants.accentColor.withValues(alpha: 0.5)
                        : AppConstants.borderColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: _elevationAnimation.value,
                      offset: Offset(0, _elevationAnimation.value / 2),
                    ),
                    if (_isHovered)
                      BoxShadow(
                        color: AppConstants.accentColor.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProjectImage(context),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.spaceMD),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProjectHeader(context),
                            const SizedBox(height: AppConstants.spaceSM),
                            _buildProjectDescription(context),
                            const Spacer(),
                            _buildTechStack(context),
                            const SizedBox(height: AppConstants.spaceMD),
                            _buildProjectActions(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build project image/thumbnail
  Widget _buildProjectImage(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConstants.radiusLG),
          topRight: Radius.circular(AppConstants.radiusLG),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppConstants.accentColor.withValues(alpha: 0.8),
            AppConstants.accentColor.withValues(alpha: 0.6),
          ],
        ),
      ),
      child: widget.project.imageUrl != null
          ? ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConstants.radiusLG),
                topRight: Radius.circular(AppConstants.radiusLG),
              ),
              child: Image.network(
                widget.project.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultProjectImage();
                },
              ),
            )
          : _buildDefaultProjectImage(),
    );
  }

  /// Build default project image
  Widget _buildDefaultProjectImage() {
    return Stack(
      children: [
        // Background pattern
        Positioned.fill(
          child: CustomPaint(
            painter: ProjectImagePainter(),
          ),
        ),
        // Project icon
        Center(
          child: Container(
            padding: const EdgeInsets.all(AppConstants.spaceMD),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            ),
            child: Icon(
              _getProjectIcon(),
              size: AppConstants.iconSizeXL,
              color: Colors.white,
            ),
          ),
        ),
        // Featured badge
        if (widget.project.featured)
          Positioned(
            top: AppConstants.spaceSM,
            right: AppConstants.spaceSM,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spaceSM,
                vertical: AppConstants.spaceXS,
              ),
              decoration: BoxDecoration(
                color: AppConstants.accentColor,
                borderRadius: BorderRadius.circular(AppConstants.radiusSM),
              ),
              child: Text(
                'FEATURED',
                style: GoogleFonts.inter(
                  fontSize: AppConstants.fontSizeCaption,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Get project icon based on language or type
  IconData _getProjectIcon() {
    final language = widget.project.language.toLowerCase();
    switch (language) {
      case 'dart':
      case 'flutter':
        return Icons.phone_android;
      case 'javascript':
      case 'typescript':
        return Icons.web;
      case 'python':
        return Icons.code;
      case 'java':
        return Icons.coffee;
      case 'swift':
        return Icons.phone_iphone;
      case 'kotlin':
        return Icons.android;
      default:
        return Icons.folder_outlined;
    }
  }

  /// Build project header with title and stats
  Widget _buildProjectHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.project.name,
            style: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeBodyLarge,
              fontWeight: FontWeight.w600,
              color: AppConstants.primaryText,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.project.stargazersCount > 0) ...[
          const SizedBox(width: AppConstants.spaceSM),
          Row(
            children: [
              Icon(
                Icons.star_outline,
                size: AppConstants.iconSizeSM,
                color: AppConstants.mutedText,
              ),
              const SizedBox(width: AppConstants.spaceXS),
              Text(
                widget.project.stargazersCount.toString(),
                style: GoogleFonts.inter(
                  fontSize: AppConstants.fontSizeBodySmall,
                  color: AppConstants.mutedText,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// Build project description
  Widget _buildProjectDescription(BuildContext context) {
    return Text(
      widget.project.description,
      style: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBodySmall,
        color: AppConstants.secondaryText,
        height: 1.5,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Build tech stack chips
  Widget _buildTechStack(BuildContext context) {
    final techStack = widget.project.techStack.take(3).toList();
    if (techStack.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: AppConstants.spaceXS,
      runSpacing: AppConstants.spaceXS,
      children: techStack.map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceSM,
            vertical: AppConstants.spaceXS,
          ),
          decoration: BoxDecoration(
            color: AppConstants.accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusSM),
            border: Border.all(
              color: AppConstants.accentColor.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            tech,
            style: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeCaption,
              fontWeight: FontWeight.w500,
              color: AppConstants.accentColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Build project actions
  Widget _buildProjectActions(BuildContext context) {
    return Row(
      children: [
        if (widget.project.htmlUrl != null)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _launchUrl(widget.project.htmlUrl!),
              icon: const Icon(
                Icons.code,
                size: AppConstants.iconSizeSM,
              ),
              label: const Text('Code'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, AppConstants.buttonHeightSmall),
                side: BorderSide(
                  color: AppConstants.borderColor,
                  width: 1,
                ),
              ),
            ),
          ),
        if (widget.project.htmlUrl != null && widget.project.homepage != null)
          const SizedBox(width: AppConstants.spaceSM),
        if (widget.project.homepage != null)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _launchUrl(widget.project.homepage!),
              icon: const Icon(
                Icons.launch,
                size: AppConstants.iconSizeSM,
              ),
              label: const Text('Demo'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, AppConstants.buttonHeightSmall),
              ),
            ),
          ),
      ],
    );
  }

  /// Launch URL in browser
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// Custom painter for project image background pattern
class ProjectImagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw grid pattern
    const spacing = 20.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
