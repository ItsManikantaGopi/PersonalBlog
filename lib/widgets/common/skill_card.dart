import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/skill.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';

/// Skill card widget with proficiency indicators and animations
class SkillCard extends StatefulWidget {
  final Skill skill;
  final bool showDescription;

  const SkillCard({
    super.key,
    required this.skill,
    this.showDescription = false,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
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

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
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
            child: Container(
              height: widget.showDescription ? null : 120,
              padding: const EdgeInsets.all(AppConstants.spaceMD),
              decoration: BoxDecoration(
                color: AppConstants.cardBackground,
                borderRadius: BorderRadius.circular(AppConstants.radiusMD),
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
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSkillHeader(context),
                  const SizedBox(height: AppConstants.spaceSM),
                  // _buildProficiencyIndicator(context),
                  if (widget.showDescription) ...[
                    const SizedBox(height: AppConstants.spaceSM),
                    _buildDescription(context),
                  ],
                  const SizedBox(height: AppConstants.spaceSM),
                  _buildExperienceInfo(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build skill header with icon and name
  Widget _buildSkillHeader(BuildContext context) {
    return Row(
      children: [
        // Skill icon
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _getSkillColor().withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusSM),
          ),
          child: Icon(
            _getSkillIcon(),
            size: AppConstants.iconSizeMD,
            color: _getSkillColor(),
          ),
        ),
        const SizedBox(width: AppConstants.spaceSM),

        // Skill name and featured badge
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.skill.name,
                      style: GoogleFonts.inter(
                        fontSize: context.responsiveValue(
                          mobile: AppConstants.fontSizeBodySmall,
                          tablet: AppConstants.fontSizeBody,
                          desktop: AppConstants.fontSizeBody,
                        ),
                        fontWeight: FontWeight.w600,
                        color: AppConstants.primaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.skill.featured)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spaceXS,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.accentColor,
                        borderRadius: BorderRadius.circular(
                          AppConstants.radiusSM,
                        ),
                      ),
                      child: Text(
                        'FEATURED',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
              Text(
                widget.skill.level.displayName,
                style: GoogleFonts.inter(
                  fontSize: context.responsiveValue(
                    mobile: AppConstants.fontSizeCaption,
                    tablet: AppConstants.fontSizeBodySmall,
                    desktop: AppConstants.fontSizeBodySmall,
                  ),
                  fontWeight: FontWeight.w400,
                  color: _getSkillColor(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build proficiency indicator
  Widget _buildProficiencyIndicator(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress bar
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: AppConstants.borderColor,
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: widget.skill.level.percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: _getSkillColor(),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build description
  Widget _buildDescription(BuildContext context) {
    return Text(
      widget.skill.description ?? '',
      style: GoogleFonts.inter(
        fontSize: AppConstants.fontSizeBodySmall,
        color: AppConstants.secondaryText,
        height: 1.4,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Build experience information
  Widget _buildExperienceInfo(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.schedule,
          size: AppConstants.iconSizeSM,
          color: AppConstants.mutedText,
        ),
        const SizedBox(width: AppConstants.spaceXS),
        Text(
          '${widget.skill.yearsOfExperience} year${widget.skill.yearsOfExperience != 1 ? 's' : ''}',
          style: GoogleFonts.inter(
            fontSize: AppConstants.fontSizeCaption,
            fontWeight: FontWeight.w400,
            color: AppConstants.mutedText,
          ),
        ),
      ],
    );
  }

  /// Get skill color based on level
  Color _getSkillColor() {
    switch (widget.skill.level) {
      case SkillLevel.expert:
        return AppConstants.accentColor;
      case SkillLevel.advanced:
        return const Color(0xFF4CAF50); // Green
      case SkillLevel.intermediate:
        return const Color(0xFFFF9800); // Orange
      case SkillLevel.beginner:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  /// Get skill icon based on category and name
  IconData _getSkillIcon() {
    // First check for specific skill icons
    switch (widget.skill.id.toLowerCase()) {
      case 'flutter':
        return Icons.phone_android;
      case 'dart':
        return Icons.code;
      case 'firebase':
        return Icons.cloud;
      case 'git':
        return Icons.source;
      case 'vscode':
        return Icons.edit_note;
      case 'android_studio':
        return Icons.android;
      case 'figma':
        return Icons.design_services;
      case 'html':
      case 'css':
      case 'javascript':
        return Icons.web;
      case 'python':
      case 'java':
        return Icons.terminal;
      case 'nodejs':
        return Icons.dns;
      case 'rest_api':
        return Icons.api;
      case 'firestore':
      case 'sqlite':
        return Icons.storage;
      case 'github_actions':
        return Icons.build;
      default:
        // Fall back to category-based icons
        switch (widget.skill.category) {
          case SkillCategory.mobileDevelopment:
            return Icons.phone_android;
          case SkillCategory.webDevelopment:
            return Icons.web;
          case SkillCategory.backend:
            return Icons.dns;
          case SkillCategory.databases:
            return Icons.storage;
          case SkillCategory.tools:
            return Icons.build;
          case SkillCategory.languages:
            return Icons.code;
          case SkillCategory.frameworks:
            return Icons.widgets;
          case SkillCategory.cloud:
            return Icons.cloud;
        }
    }
  }
}
