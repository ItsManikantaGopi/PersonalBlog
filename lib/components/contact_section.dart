import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final accentColor = const Color(0xFF00BCD4);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONTACT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 4,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () async {
            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'manikanta@example.com',
            );
            await launchUrl(emailLaunchUri);
          },
          child: Text(
            'manikanta@example.com',
            style: TextStyle(
              color: accentColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _SocialIcon(
              icon: Icons.code,
              url: 'https://github.com/ItsManikantaGopi',
              tooltip: 'GitHub',
            ),
            const SizedBox(width: 16),
            _SocialIcon(icon: Icons.link, url: '#', tooltip: 'LinkedIn'),
            const SizedBox(width: 16),
            _SocialIcon(
              icon: Icons.alternate_email,
              url: '#',
              tooltip: 'Twitter',
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final String tooltip;
  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () async {
          if (widget.url != '#') {
            await launchUrl(Uri.parse(widget.url));
          }
        },
        child: Tooltip(
          message: widget.tooltip,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()..scale(_hovering ? 1.15 : 1.0),
            child: Icon(widget.icon, color: Colors.white, size: 32),
          ),
        ),
      ),
    );
  }
}
