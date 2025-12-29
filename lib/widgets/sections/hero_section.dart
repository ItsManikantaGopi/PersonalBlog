import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';

/// Professional hero section with engaging animations
class HeroSection extends StatefulWidget {
  final VoidCallback? onViewWork;
  final VoidCallback? onDownloadResume;
  final String? profileImageUrl;

  const HeroSection({
    super.key,
    this.onViewWork,
    this.onDownloadResume,
    this.profileImageUrl,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _floatingController;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();

    // Background animation for subtle movement
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_backgroundController);

    // Floating animation for profile image
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _backgroundController.repeat();
    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: SizedBox(
        height: context.responsiveValue(
          mobile: MediaQuery.of(context).size.height * 0.9,
          tablet: MediaQuery.of(context).size.height * 0.85,
          desktop: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Stack(
          children: [
            // Animated background elements
            _buildAnimatedBackground(),

            // Main content
            ResponsiveLayout(
              mobile: _buildMobileLayout(context),
              tablet: _buildTabletLayout(context),
              desktop: _buildDesktopLayout(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Build animated background with geometric shapes
  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: CustomPaint(
            painter: BackgroundPainter(_backgroundAnimation.value),
          ),
        );
      },
    );
  }

  /// Build mobile layout
  Widget _buildMobileLayout(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            _buildProfileImage(context, size: 100),
            const SizedBox(height: AppConstants.spaceLG),
            _buildGreeting(context),
            const SizedBox(height: AppConstants.spaceMD),
            _buildRole(context),
            const SizedBox(height: AppConstants.spaceLG),
            _buildValueProposition(context),
            const SizedBox(height: AppConstants.spaceXL),
            _buildCTAButtons(context, isVertical: true),
          ],
        ),
      ),
    );
  }

  /// Build tablet layout
  Widget _buildTabletLayout(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            _buildProfileImage(context, size: 120),
            const SizedBox(height: AppConstants.spaceLG),
            _buildGreeting(context),
            const SizedBox(height: AppConstants.spaceMD),
            _buildRole(context),
            const SizedBox(height: AppConstants.spaceLG),
            _buildValueProposition(context),
            const SizedBox(height: AppConstants.spaceXL),
            _buildCTAButtons(context, isVertical: false),
          ],
        ),
      ),
    );
  }

  /// Build desktop layout
  Widget _buildDesktopLayout(BuildContext context) {
    return AnimationLimiter(
      child: Row(
        children: [
          // Left side - Text content
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: -50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  _buildGreeting(context),
                  const SizedBox(height: AppConstants.spaceMD),
                  _buildRole(context),
                  const SizedBox(height: AppConstants.spaceLG),
                  _buildValueProposition(context),
                  const SizedBox(height: AppConstants.spaceXL),
                  _buildCTAButtons(context, isVertical: false),
                ],
              ),
            ),
          ),

          const SizedBox(width: AppConstants.spaceXXL),

          // Right side - Profile image
          Expanded(
            flex: 2,
            child: AnimationConfiguration.synchronized(
              duration: const Duration(milliseconds: 800),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: Center(child: _buildProfileImage(context, size: 200)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build profile image with floating animation
  Widget _buildProfileImage(BuildContext context, {required double size}) {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppConstants.accentColor, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.accentColor.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: widget.profileImageUrl != null
                  ? Image.network(
                      widget.profileImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultAvatar(size);
                      },
                    )
                  : _buildDefaultAvatar(size),
            ),
          ),
        );
      },
    );
  }

  /// Build default avatar
  Widget _buildDefaultAvatar(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppConstants.accentColor, Color(0xFF0097A7)],
        ),
      ),
      child: Icon(Icons.person, size: size * 0.6, color: Colors.white),
    );
  }

  /// Build greeting text
  Widget _buildGreeting(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          "Hi, I'm Manikanta Gopi!",
          textStyle: GoogleFonts.inter(
            fontSize: context.responsiveValue(
              mobile: AppConstants.fontSizeH2,
              tablet: AppConstants.fontSizeH1,
              desktop: AppConstants.fontSizeDisplay,
            ),
            fontWeight: FontWeight.w700,
            color: AppConstants.primaryText,
            height: 1.2,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      totalRepeatCount: 1,
      displayFullTextOnTap: true,
    );
  }

  /// Build role text
  Widget _buildRole(BuildContext context) {
    return Text(
      'Software Engineer',
      style: GoogleFonts.inter(
        fontSize: context.responsiveValue(
          mobile: AppConstants.fontSizeBodyLarge,
          tablet: AppConstants.fontSizeH4,
          desktop: AppConstants.fontSizeH3,
        ),
        fontWeight: FontWeight.w600,
        color: AppConstants.accentColor,
        letterSpacing: context.responsiveValue(
          mobile: 2.0,
          tablet: 3.0,
          desktop: 4.0,
        ),
        height: 1.2,
      ),
    );
  }

  /// Build value proposition
  Widget _buildValueProposition(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.responsiveValue(
          mobile: double.infinity,
          tablet: 600.0,
          desktop: 500.0,
        ),
      ),
      child: Text(
        """DevOps | Backend-Systems | Event-Driven-Systems |
          CI/CD | Cloud(AWS,GCP,AZURE) | Kubernetes | Terraform | Docker |
          GitOps | Prometheus | Grafana | Loki | Promtail | Thanos |
          Redis | MySql | MongoDb | NestJS | Python | Ruby-on-Rails 
          """
            .replaceAll("\n", "")
            .replaceAll(" ", "")
            .replaceAll("-", " ")
            .replaceAll("|", "  |  "),
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
        textAlign: context.isDesktop ? TextAlign.left : TextAlign.center,
      ),
    );
  }

  /// Build CTA buttons
  Widget _buildCTAButtons(BuildContext context, {required bool isVertical}) {
    final buttons = [
      // ElevatedButton.icon(
      //   onPressed: widget.onViewWork,
      //   icon: const Icon(Icons.work_outline, size: AppConstants.iconSizeSM),
      //   label: const Text('View My Work'),
      //   style: ElevatedButton.styleFrom(
      //     minimumSize: Size(
      //       context.responsiveValue(
      //         mobile: 200.0,
      //         tablet: 180.0,
      //         desktop: 200.0,
      //       ),
      //       AppConstants.buttonHeightLarge,
      //     ),
      //   ),
      // ),
      // OutlinedButton.icon(
      //   onPressed: widget.onDownloadResume,
      //   icon: const Icon(
      //     Icons.download_outlined,
      //     size: AppConstants.iconSizeSM,
      //   ),
      //   label: const Text('Download Resume'),
      //   style: OutlinedButton.styleFrom(
      //     minimumSize: Size(
      //       context.responsiveValue(
      //         mobile: 200.0,
      //         tablet: 180.0,
      //         desktop: 200.0,
      //       ),
      //       AppConstants.buttonHeightLarge,
      //     ),
      //   ),
      // ),
    ];
    return Container();
    if (isVertical) {
      return Column(
        children: [
          buttons[0],
          const SizedBox(height: AppConstants.spaceMD),
          buttons[1],
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: context.isDesktop
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          buttons[0],
          const SizedBox(width: AppConstants.spaceMD),
          buttons[1],
        ],
      );
    }
  }
}

/// Custom painter for animated background
class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppConstants.accentColor.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    // Draw animated geometric shapes
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Rotating circles
    for (int i = 0; i < 3; i++) {
      final radius = 100.0 + (i * 50);
      final x =
          centerX +
          (radius * 0.5 * (1 + i * 0.3)) *
              (1 + 0.2 * (animationValue - 0.5).abs()) *
              (i.isEven ? 1 : -1);
      final y =
          centerY +
          (radius * 0.3 * (1 + i * 0.2)) *
              (1 + 0.1 * (animationValue - 0.5).abs()) *
              (i.isOdd ? 1 : -1);

      canvas.drawCircle(
        Offset(x, y),
        20.0 + (10 * (animationValue - 0.5).abs()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
