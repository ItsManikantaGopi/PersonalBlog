import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDark = true;

  void _toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = const Color(0xFF00BCD4);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 800;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: isMobile
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          _ThemeSwitchButton(
                            isDark: isDark,
                            onToggle: _toggleTheme,
                            accentColor: accentColor,
                          ),
                          const SizedBox(height: 24),
                          _ProfileSection(
                            isDark: isDark,
                            accentColor: accentColor,
                          ),
                          const SizedBox(height: 32),
                          _DetailsSection(
                            isDark: isDark,
                            accentColor: accentColor,
                          ),
                        ],
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ThemeSwitchButton(
                                isDark: isDark,
                                onToggle: _toggleTheme,
                                accentColor: accentColor,
                              ),
                              const SizedBox(height: 32),
                              _DetailsSection(
                                isDark: isDark,
                                accentColor: accentColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 1,
                          child: _ProfileSection(
                            isDark: isDark,
                            accentColor: accentColor,
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _ThemeSwitchButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;
  final Color accentColor;
  const _ThemeSwitchButton({
    required this.isDark,
    required this.onToggle,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(
          isDark ? Icons.dark_mode : Icons.light_mode,
          color: accentColor,
          size: 32,
        ),
        tooltip: isDark ? 'Switch to Light Theme' : 'Switch to Dark Theme',
        onPressed: onToggle,
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final bool isDark;
  final Color accentColor;
  const _ProfileSection({required this.isDark, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black87;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/58616351?v=4',
          ),
          backgroundColor: isDark ? Colors.grey[900] : Colors.grey[300],
        ),
        const SizedBox(height: 24),
        Text(
          "Hi, I'm Manikanta",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 32,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Software Engineer | DevOps | Flutter Developer',
          style: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I build scalable systems, mobile/web apps, and automate cloud infrastructure.',
          style: TextStyle(
            color: subTextColor,
            fontSize: 18,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _DetailsSection extends StatelessWidget {
  final bool isDark;
  final Color accentColor;
  const _DetailsSection({required this.isDark, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final subTextColor = isDark ? Colors.white70 : Colors.black87;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ClickableDetailsTile(
          icon: Icons.work,
          title: 'Experience',
          accentColor: accentColor,
          children: [
            Text(
              'Software Engineer II at Circleapp Online Services',
              style: TextStyle(color: subTextColor, fontSize: 16),
            ),
            Text(
              'Building scalable systems, real-time messaging, multi-cloud solutions',
              style: TextStyle(color: subTextColor, fontSize: 16),
            ),
            Text(
              'CI/CD, Kubernetes, Terraform, GitOps',
              style: TextStyle(color: subTextColor, fontSize: 16),
            ),
          ],
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Experience'),
                content: Text('More details coming soon.'),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        _ClickableDetailsTile(
          icon: Icons.star,
          title: 'Skills',
          accentColor: accentColor,
          children: [
            Text(
              'Python, Ruby, NestJS, AWS, GCP, Azure, Docker, MongoDB, MySQL, Redis',
              style: TextStyle(color: subTextColor, fontSize: 16),
            ),
            Text(
              'Grafana, Prometheus, REST APIs, WebSockets',
              style: TextStyle(color: subTextColor, fontSize: 16),
            ),
          ],
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Skills'),
                content: Text('More details coming soon.'),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        _ClickableDetailsTile(
          icon: Icons.school,
          title: 'Education',
          accentColor: accentColor,
          children: [
            Text(
              'B.Tech in Computer Science, RGUKT (2022), GPA: 9.3/10',
              style: TextStyle(color: subTextColor, fontSize: 16),
            ),
            Text(
              'Pre-University Course (MPC), RGUKT (2018), GPA: 8.4/10',
              style: TextStyle(color: subTextColor, fontSize: 16),
            ),
          ],
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Education'),
                content: Text('More details coming soon.'),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        _ClickableDetailsTile(
          icon: Icons.palette,
          title: 'Art',
          accentColor: accentColor,
          children: [
            Text(
              'Digital art and creative coding projects',
              style: TextStyle(color: subTextColor, fontSize: 16),
            ),
          ],
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Art'),
                content: Text('More details coming soon.'),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ClickableDetailsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color accentColor;
  final List<Widget> children;
  final VoidCallback onTap;
  const _ClickableDetailsTile({
    required this.icon,
    required this.title,
    required this.accentColor,
    required this.children,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accentColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
