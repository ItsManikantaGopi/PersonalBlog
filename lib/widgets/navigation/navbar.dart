import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import 'mobile_drawer.dart';

/// Navigation item data class
class NavItem {
  final String label;
  final String section;
  final IconData? icon;

  const NavItem({required this.label, required this.section, this.icon});
}

/// Professional navigation bar with responsive design
class ProfessionalNavBar extends StatefulWidget {
  final String activeSection;
  final Function(String) onSectionTap;
  final VoidCallback? onResumeDownload;
  final bool isDarkMode;
  final VoidCallback? onThemeToggle;

  const ProfessionalNavBar({
    super.key,
    required this.activeSection,
    required this.onSectionTap,
    this.onResumeDownload,
    this.isDarkMode = true,
    this.onThemeToggle,
  });

  @override
  State<ProfessionalNavBar> createState() => _ProfessionalNavBarState();
}

class _ProfessionalNavBarState extends State<ProfessionalNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isScrolled = false;

  // Navigation items
  static const List<NavItem> _navItems = [
    NavItem(label: 'About', section: 'about', icon: Icons.person_outline),
    NavItem(label: 'Projects', section: 'projects', icon: Icons.work_outline),
    NavItem(label: 'Skills', section: 'skills', icon: Icons.code_outlined),
    NavItem(label: 'Contact', section: 'contact', icon: Icons.email_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.animationNormal,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateScrollState(bool isScrolled) {
    if (_isScrolled != isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            _updateScrollState(scrollNotification.metrics.pixels > 50);
            return false;
          },
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return AnimatedContainer(
                duration: AppConstants.animationNormal,
                decoration: BoxDecoration(
                  color: _isScrolled
                      ? AppConstants.primaryBackground.withValues(alpha: 0.95)
                      : Colors.transparent,
                  border: _isScrolled
                      ? const Border(
                          bottom: BorderSide(
                            color: AppConstants.borderColor,
                            width: 1,
                          ),
                        )
                      : null,
                ),
                child: BackdropFilter(
                  filter: _isScrolled
                      ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                      : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(
                    height: AppConstants.navBarHeight,
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveValue(
                        mobile: AppConstants.spaceMD,
                        tablet: AppConstants.spaceLG,
                        desktop: AppConstants.spaceXL,
                      ),
                    ),
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: deviceType == DeviceType.mobile
                          ? _buildMobileNavBar(context)
                          : _buildDesktopNavBar(context),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Build desktop navigation bar
  Widget _buildDesktopNavBar(BuildContext context) {
    return Row(
      children: [
        // Brand/Logo
        _buildBrand(context),

        const Spacer(),

        // Navigation items
        ..._navItems.map((item) => _buildNavItem(context, item)),

        const SizedBox(width: AppConstants.spaceLG),

        // Theme toggle
        if (widget.onThemeToggle != null) ...[
          _buildThemeToggle(context),
          const SizedBox(width: AppConstants.spaceMD),
        ],

        // Resume download button
        if (widget.onResumeDownload != null) _buildResumeButton(context),
      ],
    );
  }

  /// Build mobile navigation bar
  Widget _buildMobileNavBar(BuildContext context) {
    return Row(
      children: [
        // Brand/Logo
        _buildBrand(context),

        const Spacer(),

        // Theme toggle
        if (widget.onThemeToggle != null) ...[
          _buildThemeToggle(context),
          const SizedBox(width: AppConstants.spaceSM),
        ],

        // Mobile menu button
        _buildMobileMenuButton(context),
      ],
    );
  }

  /// Build brand/logo
  Widget _buildBrand(BuildContext context) {
    return InkWell(
      onTap: () => widget.onSectionTap('hero'),
      borderRadius: BorderRadius.circular(AppConstants.radiusSM),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceSM,
          vertical: AppConstants.spaceSM,
        ),
        child: Text(
          'MANIKANTA',
          style: GoogleFonts.inter(
            fontSize: context.responsiveValue(
              mobile: 18.0,
              tablet: 20.0,
              desktop: 22.0,
            ),
            fontWeight: FontWeight.w700,
            color: AppConstants.primaryText,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  /// Build navigation item
  Widget _buildNavItem(BuildContext context, NavItem item) {
    final isActive = widget.activeSection == item.section;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceSM),
      child: InkWell(
        onTap: () => widget.onSectionTap(item.section),
        borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        child: AnimatedContainer(
          duration: AppConstants.animationNormal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceMD,
            vertical: AppConstants.spaceSM,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusSM),
            border: isActive
                ? Border(
                    bottom: BorderSide(
                      color: AppConstants.accentColor,
                      width: 2,
                    ),
                  )
                : null,
          ),
          child: Text(
            item.label,
            style: GoogleFonts.inter(
              fontSize: AppConstants.fontSizeBody,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive
                  ? AppConstants.accentColor
                  : AppConstants.primaryText,
            ),
          ),
        ),
      ),
    );
  }

  /// Build theme toggle button
  Widget _buildThemeToggle(BuildContext context) {
    return IconButton(
      onPressed: widget.onThemeToggle,
      icon: Icon(
        widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: AppConstants.primaryText,
        size: AppConstants.iconSizeMD,
      ),
      tooltip: widget.isDarkMode
          ? 'Switch to Light Mode'
          : 'Switch to Dark Mode',
      splashRadius: 20,
    );
  }

  /// Build resume download button
  Widget _buildResumeButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: widget.onResumeDownload,
      icon: const Icon(Icons.download_outlined, size: AppConstants.iconSizeSM),
      label: Text(
        context.responsiveValue(mobile: 'Resume', desktop: 'Download Resume'),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          context.responsiveValue(mobile: 100.0, desktop: 160.0),
          AppConstants.buttonHeight,
        ),
      ),
    );
  }

  /// Build mobile menu button
  Widget _buildMobileMenuButton(BuildContext context) {
    return IconButton(
      onPressed: () => _showMobileDrawer(context),
      icon: const Icon(
        Icons.menu,
        color: AppConstants.primaryText,
        size: AppConstants.iconSizeMD,
      ),
      tooltip: 'Open Menu',
      splashRadius: 20,
    );
  }

  /// Show mobile drawer
  void _showMobileDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => MobileDrawer(
        navItems: _navItems,
        activeSection: widget.activeSection,
        onSectionTap: (section) {
          Navigator.pop(context);
          widget.onSectionTap(section);
        },
        onResumeDownload: widget.onResumeDownload,
      ),
    );
  }
}
