import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../models/skill.dart';
import '../../data/portfolio_data.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import '../common/skill_card.dart';

/// Skills and technologies section
class SkillsSection extends StatefulWidget {
  final SkillCategory? selectedCategory;

  const SkillsSection({super.key, this.selectedCategory});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final Map<SkillCategory, List<Skill>> _skillsByCategory =
      PortfolioData.getSkillsGroupedByCategory();
  late List<SkillCategory> _categories;

  @override
  void initState() {
    super.initState();
    _categories = _skillsByCategory.keys.toList();
    _tabController = TabController(length: _categories.length, vsync: this);

    // Set initial tab if category is specified
    if (widget.selectedCategory != null) {
      final index = _categories.indexOf(widget.selectedCategory!);
      if (index != -1) {
        _tabController.index = index;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context),
          // const SizedBox(height: AppConstants.spaceXL),
          // _buildSkillsStats(context),
          const SizedBox(height: AppConstants.spaceXL),
          _buildCategoryTabs(context),
          const SizedBox(height: AppConstants.spaceLG),
          _buildSkillsContent(context),
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
          'Skills & Technologies',
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
            'A comprehensive overview of my technical expertise across mobile development, '
            'web technologies, and modern development tools. Each skill represents '
            'hands-on experience in real-world projects.',
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

  /// Build skills statistics
  // Widget _buildSkillsStats(BuildContext context) {
  //   final stats = PortfolioData.getTechnologyStats();

  //   return ResponsiveLayout(
  //     mobile: _buildMobileStats(context, stats),
  //     tablet: _buildTabletStats(context, stats),
  //     desktop: _buildDesktopStats(context, stats),
  //   );
  // }

  // Widget _buildMobileStats(BuildContext context, Map<String, dynamic> stats) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Expanded(
  //             child: _buildStatCard(
  //               context,
  //               'Total Skills',
  //               stats['totalSkills'],
  //             ),
  //           ),
  //           const SizedBox(width: AppConstants.spaceMD),
  //           Expanded(
  //             child: _buildStatCard(
  //               context,
  //               'Expert Level',
  //               stats['expertSkills'],
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: AppConstants.spaceMD),
  //       Row(
  //         children: [
  //           Expanded(
  //             child: _buildStatCard(
  //               context,
  //               'Advanced',
  //               stats['advancedSkills'],
  //             ),
  //           ),
  //           const SizedBox(width: AppConstants.spaceMD),
  //           Expanded(
  //             child: _buildStatCard(
  //               context,
  //               'Featured',
  //               stats['featuredSkills'],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildTabletStats(BuildContext context, Map<String, dynamic> stats) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: _buildStatCard(context, 'Total Skills', stats['totalSkills']),
  //       ),
  //       const SizedBox(width: AppConstants.spaceMD),
  //       Expanded(
  //         child: _buildStatCard(context, 'Expert Level', stats['expertSkills']),
  //       ),
  //       const SizedBox(width: AppConstants.spaceMD),
  //       Expanded(
  //         child: _buildStatCard(context, 'Advanced', stats['advancedSkills']),
  //       ),
  //       const SizedBox(width: AppConstants.spaceMD),
  //       Expanded(
  //         child: _buildStatCard(context, 'Featured', stats['featuredSkills']),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildDesktopStats(BuildContext context, Map<String, dynamic> stats) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: _buildStatCard(context, 'Total Skills', stats['totalSkills']),
  //       ),
  //       const SizedBox(width: AppConstants.spaceLG),
  //       Expanded(
  //         child: _buildStatCard(context, 'Expert Level', stats['expertSkills']),
  //       ),
  //       const SizedBox(width: AppConstants.spaceLG),
  //       Expanded(
  //         child: _buildStatCard(context, 'Advanced', stats['advancedSkills']),
  //       ),
  //       const SizedBox(width: AppConstants.spaceLG),
  //       Expanded(
  //         child: _buildStatCard(context, 'Featured', stats['featuredSkills']),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildStatCard(BuildContext context, String label, int value) {
  //   return Container(
  //     padding: const EdgeInsets.all(AppConstants.spaceMD),
  //     decoration: BoxDecoration(
  //       color: AppConstants.cardBackground,
  //       borderRadius: BorderRadius.circular(AppConstants.radiusMD),
  //       border: Border.all(color: AppConstants.borderColor, width: 1),
  //     ),
  //     child: Column(
  //       children: [
  //         Text(
  //           value.toString(),
  //           style: GoogleFonts.inter(
  //             fontSize: context.responsiveValue(
  //               mobile: AppConstants.fontSizeH3,
  //               tablet: AppConstants.fontSizeH2,
  //               desktop: AppConstants.fontSizeH2,
  //             ),
  //             fontWeight: FontWeight.w700,
  //             color: AppConstants.accentColor,
  //           ),
  //         ),
  //         const SizedBox(height: AppConstants.spaceXS),
  //         Text(
  //           label,
  //           style: GoogleFonts.inter(
  //             fontSize: context.responsiveValue(
  //               mobile: AppConstants.fontSizeBodySmall,
  //               tablet: AppConstants.fontSizeBody,
  //               desktop: AppConstants.fontSizeBody,
  //             ),
  //             fontWeight: FontWeight.w500,
  //             color: AppConstants.secondaryText,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Build category tabs
  Widget _buildCategoryTabs(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(color: AppConstants.borderColor, width: 1),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: context.isMobile,
        tabAlignment: context.isMobile ? TabAlignment.start : TabAlignment.fill,
        indicator: BoxDecoration(
          color: AppConstants.accentColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppConstants.accentColor,
        unselectedLabelColor: AppConstants.secondaryText,
        labelStyle: GoogleFonts.inter(
          fontSize: context.responsiveValue(
            mobile: AppConstants.fontSizeBodySmall,
            tablet: AppConstants.fontSizeBody,
            desktop: AppConstants.fontSizeBody,
          ),
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: context.responsiveValue(
            mobile: AppConstants.fontSizeBodySmall,
            tablet: AppConstants.fontSizeBody,
            desktop: AppConstants.fontSizeBody,
          ),
          fontWeight: FontWeight.w400,
        ),
        tabs: _categories.map((category) {
          return Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(category.icon),
                const SizedBox(width: AppConstants.spaceXS),
                Flexible(
                  child: Text(
                    category.displayName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Build skills content
  Widget _buildSkillsContent(BuildContext context) {
    return SizedBox(
      height: context.responsiveValue(
        mobile: 400.0,
        tablet: 450.0,
        desktop: 500.0,
      ),
      child: TabBarView(
        controller: _tabController,
        children: _categories.map((category) {
          final skills = _skillsByCategory[category] ?? [];
          return _buildSkillsGrid(context, skills);
        }).toList(),
      ),
    );
  }

  /// Build skills grid for a category
  Widget _buildSkillsGrid(BuildContext context, List<Skill> skills) {
    if (skills.isEmpty) {
      return Center(
        child: Text(
          'No skills in this category',
          style: GoogleFonts.inter(
            fontSize: AppConstants.fontSizeBody,
            color: AppConstants.mutedText,
          ),
        ),
      );
    }

    return AnimationLimiter(
      child: ResponsiveGrid(
        mobileColumns: 2,
        tabletColumns: 3,
        desktopColumns: 4,
        spacing: AppConstants.spaceMD,
        children: skills.asMap().entries.map((entry) {
          final index = entry.key;
          final skill = entry.value;

          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 400),
            columnCount: context.responsiveValue(
              mobile: 2,
              tablet: 3,
              desktop: 4,
            ),
            child: SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(child: SkillCard(skill: skill)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
