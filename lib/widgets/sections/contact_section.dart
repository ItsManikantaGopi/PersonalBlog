import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/social_link.dart';
import '../../data/portfolio_data.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';

/// Contact section with form and social links
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context),
          const SizedBox(height: AppConstants.spaceXL),
          ResponsiveLayout(
            mobile: _buildMobileLayout(context),
            tablet: _buildTabletLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(BuildContext context) {
    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get In Touch',
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
                  'Have a project in mind or want to discuss opportunities? '
                  'I\'d love to hear from you. Send me a message and I\'ll '
                  'get back to you as soon as possible.',
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
          ),
        ),
      ),
    );
  }

  /// Build mobile layout
  Widget _buildMobileLayout(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 400),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 30.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            _buildContactForm(context),
            const SizedBox(height: AppConstants.spaceXL),
            _buildSocialLinks(context),
          ],
        ),
      ),
    );
  }

  /// Build tablet layout
  Widget _buildTabletLayout(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 400),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 30.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            _buildContactForm(context),
            const SizedBox(height: AppConstants.spaceXL),
            _buildSocialLinks(context),
          ],
        ),
      ),
    );
  }

  /// Build desktop layout
  Widget _buildDesktopLayout(BuildContext context) {
    return AnimationLimiter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact form
          Expanded(
            flex: 3,
            child: AnimationConfiguration.synchronized(
              duration: const Duration(milliseconds: 600),
              child: SlideAnimation(
                horizontalOffset: -50.0,
                child: FadeInAnimation(child: _buildContactForm(context)),
              ),
            ),
          ),

          const SizedBox(width: AppConstants.spaceXXL),

          // Social links and contact info
          Expanded(
            flex: 2,
            child: AnimationConfiguration.synchronized(
              duration: const Duration(milliseconds: 600),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildContactInfo(context),
                      const SizedBox(height: AppConstants.spaceXL),
                      _buildSocialLinks(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build contact form
  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceLG),
      decoration: BoxDecoration(
        color: AppConstants.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        border: Border.all(color: AppConstants.borderColor, width: 1),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Message',
              style: GoogleFonts.inter(
                fontSize: AppConstants.fontSizeH4,
                fontWeight: FontWeight.w600,
                color: AppConstants.primaryText,
              ),
            ),
            const SizedBox(height: AppConstants.spaceLG),

            // Name field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                hintText: 'Enter your full name',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.spaceMD),

            // Email field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter your email address',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.spaceMD),

            // Message field
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Message',
                hintText: 'Tell me about your project or inquiry...',
                prefixIcon: Icon(Icons.message_outlined),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your message';
                }
                if (value.trim().length < 10) {
                  return 'Message should be at least 10 characters long';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.spaceLG),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSubmitting ? null : _submitForm,
                icon: _isSubmitting
                    ? const SizedBox(
                        width: AppConstants.iconSizeSM,
                        height: AppConstants.iconSizeSM,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(_isSubmitting ? 'Sending...' : 'Send Message'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    AppConstants.buttonHeightLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build contact information
  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: GoogleFonts.inter(
            fontSize: AppConstants.fontSizeH4,
            fontWeight: FontWeight.w600,
            color: AppConstants.primaryText,
          ),
        ),
        const SizedBox(height: AppConstants.spaceMD),

        _buildContactInfoItem(
          context,
          icon: Icons.email_outlined,
          label: 'Email',
          value: 'manikanta.gopi@example.com',
          onTap: () => _launchUrl('mailto:manikanta.gopi@example.com'),
        ),
        const SizedBox(height: AppConstants.spaceMD),

        _buildContactInfoItem(
          context,
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: 'Available for Remote Work',
        ),
        const SizedBox(height: AppConstants.spaceMD),

        _buildContactInfoItem(
          context,
          icon: Icons.schedule_outlined,
          label: 'Response Time',
          value: 'Usually within 24 hours',
        ),
      ],
    );
  }

  Widget _buildContactInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spaceMD),
        decoration: BoxDecoration(
          color: AppConstants.cardBackground,
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          border: Border.all(color: AppConstants.borderColor, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.spaceSM),
              decoration: BoxDecoration(
                color: AppConstants.accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusSM),
              ),
              child: Icon(
                icon,
                size: AppConstants.iconSizeMD,
                color: AppConstants.accentColor,
              ),
            ),
            const SizedBox(width: AppConstants.spaceMD),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: AppConstants.fontSizeBodySmall,
                      fontWeight: FontWeight.w500,
                      color: AppConstants.secondaryText,
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: AppConstants.fontSizeBody,
                      fontWeight: FontWeight.w600,
                      color: onTap != null
                          ? AppConstants.accentColor
                          : AppConstants.primaryText,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                size: AppConstants.iconSizeSM,
                color: AppConstants.mutedText,
              ),
          ],
        ),
      ),
    );
  }

  /// Build social links
  Widget _buildSocialLinks(BuildContext context) {
    final socialLinks = PortfolioData.getFeaturedSocialLinks();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect With Me',
          style: GoogleFonts.inter(
            fontSize: AppConstants.fontSizeH4,
            fontWeight: FontWeight.w600,
            color: AppConstants.primaryText,
          ),
        ),
        const SizedBox(height: AppConstants.spaceMD),

        Wrap(
          spacing: AppConstants.spaceMD,
          runSpacing: AppConstants.spaceMD,
          children: socialLinks.map((link) {
            return _buildSocialLinkButton(context, link);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialLinkButton(BuildContext context, SocialLink link) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(color: AppConstants.borderColor, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchUrl(link.url),
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spaceMD),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getIconForPlatform(link.platform),
                  size: AppConstants.iconSizeMD,
                  color: AppConstants.accentColor,
                ),
                const SizedBox(width: AppConstants.spaceSM),
                Text(
                  link.platform.displayName,
                  style: GoogleFonts.inter(
                    fontSize: AppConstants.fontSizeBody,
                    fontWeight: FontWeight.w500,
                    color: AppConstants.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Submit form
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate form submission
      await Future.delayed(const Duration(seconds: 2));

      // In a real app, you would send the form data to your backend
      // For now, we'll just show a success message and clear the form

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Message sent successfully! I\'ll get back to you soon.',
            ),
            backgroundColor: AppConstants.accentColor,
            behavior: SnackBarBehavior.floating,
          ),
        );

        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send message. Please try again.'),
            backgroundColor: AppConstants.errorColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  /// Launch URL
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Get icon for social platform
  IconData _getIconForPlatform(SocialPlatform platform) {
    switch (platform) {
      case SocialPlatform.github:
        return Icons.code;
      case SocialPlatform.linkedin:
        return Icons.work;
      case SocialPlatform.twitter:
        return Icons.alternate_email;
      case SocialPlatform.email:
        return Icons.email;
      case SocialPlatform.website:
        return Icons.language;
      case SocialPlatform.instagram:
        return Icons.camera_alt;
      case SocialPlatform.youtube:
        return Icons.play_circle;
      case SocialPlatform.medium:
        return Icons.article;
      case SocialPlatform.stackoverflow:
        return Icons.help;
      case SocialPlatform.discord:
        return Icons.chat;
    }
  }
}
