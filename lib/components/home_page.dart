import 'package:flutter/material.dart';
import 'profile_picture.dart';
import 'blog_options.dart';
import 'work_experience.dart';
import 'other_options.dart';
import 'titles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Titles titles = const Titles();
  double get ProfileImageRadius => 80;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          titles.profileTitle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Show profile avatar and info
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    height:
                        MediaQuery.of(context).size.width *
                        (ProfileImageRadius / 1000),
                    width:
                        MediaQuery.of(context).size.width *
                        (ProfileImageRadius / 1000),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://avatars.githubusercontent.com/u/58616351?v=4',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(
                        ProfileImageRadius.toDouble(),
                      ),
                    ),
                  ),
                ],
              ),

              // Navigation buttons
              ElevatedButton.icon(
                icon: const Icon(Icons.person),
                label: Text(
                  titles.profileTitle,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(titles: titles),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.transparent,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.article),
                label: Text(titles.blogTitle),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogScreen(titles: titles),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.work),
                label: Text(titles.workExperienceTitle),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WorkExperienceScreen(titles: titles),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.more_horiz),
                label: Text(titles.otherTitle),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtherScreen(titles: titles),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
