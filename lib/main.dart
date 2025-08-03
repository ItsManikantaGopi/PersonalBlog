import 'package:flutter/material.dart';
import 'package:manikanta_blog_web/components/titles.dart';
import 'components/home_page.dart';
import 'features/about/about_page.dart';
import 'features/experience/experience_page.dart';
import 'features/skills/skills_page.dart';
import 'features/projects/projects_page.dart';
import 'features/education/education_page.dart';
import 'features/github/github_analytics_page.dart';
import 'features/art/art.dart';
import 'components/footer_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0E1A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
          background: const Color(0xFF0A0E1A),
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        useMaterial3: true,
      );

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          background: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        useMaterial3: true,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manikanta Gopi',
      theme: isDark ? darkTheme : lightTheme,
      home: PortfolioApp(
        isDark: isDark,
        onThemeToggle: () => setState(() => isDark = !isDark),
      ),
    );
  }
}

class PortfolioApp extends StatefulWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;
  const PortfolioApp({
    Key? key,
    required this.isDark,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    AboutPage(),
    ExperiencePage(),
    SkillsPage(),
    ProjectsPage(),
    EducationPage(),
    GithubAnalyticsPage(),
    Art(titles: Titles()),
  ];

  final List<String> _titles = const [
    'Home',
    'About',
    'Experience',
    'Skills',
    'Projects',
    'Education',
    'GitHub Analytics',
    'Art',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  'Manikanta Gopi',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const Spacer(),
                ...List.generate(
                  _titles.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () => setState(() => _selectedIndex = index),
                      child: Text(
                        _titles[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: _selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: _selectedIndex == index
                              ? const Color(0xFF00D4FF)
                              : Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    widget.isDark ? Icons.dark_mode : Icons.light_mode,
                    color: Colors.white,
                  ),
                  onPressed: widget.onThemeToggle,
                  tooltip: widget.isDark
                      ? 'Switch to Light Mode'
                      : 'Switch to Dark Mode',
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00D4FF),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    // TODO: Implement resume download
                  },
                  child: const Text('Download Resume'),
                ),
              ],
            ),
          ),
          Expanded(child: _pages[_selectedIndex]),
          const FooterWidget(),
        ],
      ),
    );
  }
}
