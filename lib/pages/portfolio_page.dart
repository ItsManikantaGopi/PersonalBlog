import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/navigation/navbar.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/contact_section.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';

/// Main portfolio page
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'projects': GlobalKey(),
    'skills': GlobalKey(),
    'contact': GlobalKey(),
  };

  String _activeSection = 'home';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollPosition = _scrollController.position.pixels;
    final viewportHeight = _scrollController.position.viewportDimension;

    String newActiveSection = 'home';

    for (final entry in _sectionKeys.entries) {
      final key = entry.value;
      final context = key.currentContext;

      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final sectionTop = position.dy + scrollPosition;
          final sectionBottom = sectionTop + renderBox.size.height;

          // Check if section is in viewport
          if (sectionTop <= scrollPosition + viewportHeight * 0.5 &&
              sectionBottom >= scrollPosition + viewportHeight * 0.5) {
            newActiveSection = entry.key;
          }
        }
      }
    }

    if (newActiveSection != _activeSection) {
      setState(() {
        _activeSection = newActiveSection;
      });
    }
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: AppConstants.animationSlow,
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _downloadResume() async {
    try {
      // In a real app, you would have a resume file hosted somewhere
      // For now, we'll show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Resume download will be available soon!'),
          backgroundColor: AppConstants.accentColor,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Example of how you would download a resume:
      // const resumeUrl = 'https://your-domain.com/resume.pdf';
      // final uri = Uri.parse(resumeUrl);
      // if (await canLaunchUrl(uri)) {
      //   await launchUrl(uri, mode: LaunchMode.externalApplication);
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to download resume. Please try again.'),
          backgroundColor: AppConstants.errorColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryBackground,
      body: Stack(
        children: [
          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys['home'],
                  child: HeroSection(
                    onViewWork: () => _scrollToSection('projects'),
                    onDownloadResume: _downloadResume,
                    profileImageUrl:
                        'https://avatars.githubusercontent.com/u/ItsManikantaGopi', // GitHub avatar
                  ),
                ),
              ),

              // Projects Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys['projects'],
                  padding: EdgeInsets.symmetric(
                    vertical: context.responsiveValue(
                      mobile: AppConstants.sectionPaddingMobile,
                      tablet: AppConstants.sectionPaddingTablet,
                      desktop: AppConstants.sectionPaddingDesktop,
                    ),
                  ),
                  child: const ProjectsSection(),
                ),
              ),

              // Skills Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys['skills'],
                  padding: EdgeInsets.symmetric(
                    vertical: context.responsiveValue(
                      mobile: AppConstants.sectionPaddingMobile,
                      tablet: AppConstants.sectionPaddingTablet,
                      desktop: AppConstants.sectionPaddingDesktop,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.cardBackground.withValues(alpha: 0.3),
                  ),
                  child: const SkillsSection(),
                ),
              ),

              // Contact Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys['contact'],
                  padding: EdgeInsets.symmetric(
                    vertical: context.responsiveValue(
                      mobile: AppConstants.sectionPaddingMobile,
                      tablet: AppConstants.sectionPaddingTablet,
                      desktop: AppConstants.sectionPaddingDesktop,
                    ),
                  ),
                  child: const ContactSection(),
                ),
              ),

              // Footer
              SliverToBoxAdapter(child: _buildFooter(context)),
            ],
          ),

          // Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ProfessionalNavBar(
              activeSection: _activeSection,
              onSectionTap: _scrollToSection,
              onResumeDownload: _downloadResume,
            ),
          ),
        ],
      ),
    );
  }

  /// Build footer
  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        context.responsiveValue(
          mobile: AppConstants.spaceLG,
          tablet: AppConstants.spaceXL,
          desktop: AppConstants.spaceXXL,
        ),
      ),
      decoration: const BoxDecoration(
        color: AppConstants.cardBackground,
        border: Border(
          top: BorderSide(color: AppConstants.borderColor, width: 1),
        ),
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            // Footer content
            ResponsiveLayout(
              mobile: _buildMobileFooter(context),
              tablet: _buildTabletFooter(context),
              desktop: _buildDesktopFooter(context),
            ),

            const SizedBox(height: AppConstants.spaceLG),

            // Copyright
            Container(
              padding: const EdgeInsets.only(top: AppConstants.spaceLG),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppConstants.borderColor, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© 2024 Manikanta Gopi. All rights reserved.',
                    style: TextStyle(
                      fontSize: context.responsiveValue(
                        mobile: AppConstants.fontSizeBodySmall,
                        tablet: AppConstants.fontSizeBody,
                        desktop: AppConstants.fontSizeBody,
                      ),
                      color: AppConstants.mutedText,
                    ),
                  ),
                  if (context.isDesktop)
                    Text(
                      'Built with Flutter 💙',
                      style: TextStyle(
                        fontSize: AppConstants.fontSizeBody,
                        color: AppConstants.mutedText,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Manikanta Gopi',
          style: TextStyle(
            fontSize: AppConstants.fontSizeH4,
            fontWeight: FontWeight.w700,
            color: AppConstants.primaryText,
          ),
        ),
        const SizedBox(height: AppConstants.spaceSM),
        Text(
          'Flutter Developer',
          style: TextStyle(
            fontSize: AppConstants.fontSizeBody,
            color: AppConstants.accentColor,
          ),
        ),
        const SizedBox(height: AppConstants.spaceMD),
        Text(
          'Building exceptional mobile and web experiences',
          style: TextStyle(
            fontSize: AppConstants.fontSizeBodySmall,
            color: AppConstants.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTabletFooter(BuildContext context) {
    return _buildMobileFooter(context);
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manikanta Gopi',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeH4,
                  fontWeight: FontWeight.w700,
                  color: AppConstants.primaryText,
                ),
              ),
              const SizedBox(height: AppConstants.spaceSM),
              Text(
                'Flutter Developer',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeBody,
                  color: AppConstants.accentColor,
                ),
              ),
              const SizedBox(height: AppConstants.spaceMD),
              Text(
                'Building exceptional mobile and web experiences\nwith modern technologies and best practices.',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeBodySmall,
                  color: AppConstants.secondaryText,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Links',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeBodyLarge,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.primaryText,
                ),
              ),
              const SizedBox(height: AppConstants.spaceMD),
              _buildFooterLink('Home', () => _scrollToSection('home')),
              _buildFooterLink('Projects', () => _scrollToSection('projects')),
              _buildFooterLink('Skills', () => _scrollToSection('skills')),
              _buildFooterLink('Contact', () => _scrollToSection('contact')),
            ],
          ),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Connect',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeBodyLarge,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.primaryText,
                ),
              ),
              const SizedBox(height: AppConstants.spaceMD),
              _buildFooterLink(
                'GitHub',
                () => _launchUrl('https://github.com/ItsManikantaGopi'),
              ),
              _buildFooterLink(
                'LinkedIn',
                () => _launchUrl('https://linkedin.com/in/manikanta-gopi'),
              ),
              _buildFooterLink(
                'Email',
                () => _launchUrl('mailto:manikanta.gopi@example.com'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spaceXS),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: AppConstants.fontSizeBodySmall,
            color: AppConstants.secondaryText,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
