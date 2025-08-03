import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final accentColor = const Color(0xFF00BCD4);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: const Color(0xFF121212),
      child: Row(
        children: [
          Text(
            'MANIKANTA',
            style: TextStyle(
              color: accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Inter',
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          _NavLink(
            title: 'About',
            accentColor: accentColor,
            onTap: () => _scrollTo(context, 'about'),
          ),
          const SizedBox(width: 24),
          _NavLink(
            title: 'Projects',
            accentColor: accentColor,
            onTap: () => _scrollTo(context, 'projects'),
          ),
          const SizedBox(width: 24),
          _NavLink(
            title: 'Contact',
            accentColor: accentColor,
            onTap: () => _scrollTo(context, 'contact'),
          ),
        ],
      ),
    );
  }

  void _scrollTo(BuildContext context, String section) {
    // Implement smooth scroll logic if needed
  }
}

class _NavLink extends StatefulWidget {
  final String title;
  final Color accentColor;
  final VoidCallback onTap;
  const _NavLink({
    required this.title,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            decoration: _hovering
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: widget.accentColor,
            decorationThickness: 2,
            fontFamily: 'Inter',
          ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}
