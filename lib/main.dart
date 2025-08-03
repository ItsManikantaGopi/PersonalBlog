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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manikanta Gopi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const PortfolioApp(),
    );
  }
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: _titles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_titles[index]),
              selected: _selectedIndex == index,
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _pages[_selectedIndex]),
          const FooterWidget(),
        ],
      ),
    );
  }
}
