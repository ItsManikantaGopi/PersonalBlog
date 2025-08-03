import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants.dart';
import 'navbar.dart';

/// Mobile navigation drawer
class MobileDrawer extends StatefulWidget {
  final List<NavItem> navItems;
  final String activeSection;
  final Function(String) onSectionTap;
  final VoidCallback? onResumeDownload;

  const MobileDrawer({
    super.key,
    required this.navItems,
    required this.activeSection,
    required this.onSectionTap,
    this.onResumeDownload,
  });

  @override
  State<MobileDrawer> createState() => _MobileDrawerState();
}

class _MobileDrawerState extends State<MobileDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.animationSlow,
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _closeDrawer() {
    _animationController.reverse().then((_) {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          children: [
            // Background overlay
            GestureDetector(
              onTap: _closeDrawer,
              child: Container(
                color: Colors.black.withValues(
                  alpha: 0.5 * _fadeAnimation.value,
                ),
              ),
            ),
            
            // Drawer content
            Align(
              alignment: Alignment.bottomCenter,
              child: Transform.translate(
                offset: Offset(
                  0,
                  MediaQuery.of(context).size.height * 0.6 * _slideAnimation.value,
                ),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: const BoxDecoration(
                    color: AppConstants.cardBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radiusXL),
                      topRight: Radius.circular(AppConstants.radiusXL),
                    ),
                    border: Border(
                      top: BorderSide(
                        color: AppConstants.borderColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Handle bar
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(
                          top: AppConstants.spaceMD,
                          bottom: AppConstants.spaceLG,
                        ),
                        decoration: BoxDecoration(
                          color: AppConstants.mutedText,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      
                      // Header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spaceLG,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Navigation',
                              style: GoogleFonts.inter(
                                fontSize: AppConstants.fontSizeH4,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.primaryText,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: _closeDrawer,
                              icon: const Icon(
                                Icons.close,
                                color: AppConstants.primaryText,
                                size: AppConstants.iconSizeMD,
                              ),
                              splashRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: AppConstants.spaceMD),
                      
                      // Navigation items
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.spaceLG,
                          ),
                          itemCount: widget.navItems.length,
                          itemBuilder: (context, index) {
                            final item = widget.navItems[index];
                            return _buildMobileNavItem(item, index);
                          },
                        ),
                      ),
                      
                      // Resume download button
                      if (widget.onResumeDownload != null) ...[
                        const Divider(color: AppConstants.borderColor),
                        Padding(
                          padding: const EdgeInsets.all(AppConstants.spaceLG),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _closeDrawer();
                                widget.onResumeDownload?.call();
                              },
                              icon: const Icon(
                                Icons.download_outlined,
                                size: AppConstants.iconSizeSM,
                              ),
                              label: const Text('Download Resume'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(
                                  double.infinity,
                                  AppConstants.buttonHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobileNavItem(NavItem item, int index) {
    final isActive = widget.activeSection == item.section;
    
    return AnimatedContainer(
      duration: AppConstants.animationNormal,
      margin: const EdgeInsets.only(bottom: AppConstants.spaceSM),
      decoration: BoxDecoration(
        color: isActive
            ? AppConstants.accentColor.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: isActive
            ? Border.all(
                color: AppConstants.accentColor.withValues(alpha: 0.3),
                width: 1,
              )
            : null,
      ),
      child: ListTile(
        leading: item.icon != null
            ? Icon(
                item.icon,
                color: isActive
                    ? AppConstants.accentColor
                    : AppConstants.primaryText,
                size: AppConstants.iconSizeMD,
              )
            : null,
        title: Text(
          item.label,
          style: GoogleFonts.inter(
            fontSize: AppConstants.fontSizeBodyLarge,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive
                ? AppConstants.accentColor
                : AppConstants.primaryText,
          ),
        ),
        onTap: () => widget.onSectionTap(item.section),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceMD,
          vertical: AppConstants.spaceSM,
        ),
      ),
    );
  }
}
