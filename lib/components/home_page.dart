import 'package:flutter/material.dart';
import 'blog_options.dart';
import 'work_experience.dart';
import '../features/art/art.dart';
import 'titles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Titles titles = const Titles(); // Keep this line for context
  double get ProfileImageRadius => 80;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 48.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/58616351?v=4',
                  ),
                  backgroundColor: Colors.grey[900],
                ),
                const SizedBox(height: 24),
                const Text(
                  "👋 Hey there! I'm Gopi Manikanta",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Software Engineer | DevOps Expert | Cloud Architecture Specialist | Real-time Systems Developer | Full-Stack Engineer',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.linked_camera,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {},
                      tooltip: 'LinkedIn',
                    ),
                    IconButton(
                      icon: const Icon(Icons.email, color: Colors.redAccent),
                      onPressed: () {},
                      tooltip: 'Gmail',
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.purpleAccent,
                      ),
                      onPressed: () {},
                      tooltip: 'Instagram',
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                      onPressed: () {},
                      tooltip: 'Facebook',
                    ),
                    IconButton(
                      icon: const Icon(Icons.code, color: Colors.white),
                      onPressed: () {},
                      tooltip: 'GitHub',
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '🚀 About Me',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Building scalable systems that handle high-volume traffic while optimizing for performance and reliability',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Software Engineer II at Circleapp Online Services with 3+ years of hands-on experience',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Performance Optimization: Reduced API response times by 200ms through CDN integration',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Scale: Developed high-throughput real-time messaging systems',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Multi-Cloud Expert: Proficient across AWS, GCP, and Azure platforms',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '🎯 Current Focus',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '- Building robust CI/CD pipelines with GitOps, Kubernetes & Terraform',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '- Architecting microservices for high-scale social media platforms',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '- Flutter mobile development experience',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '- Implementing disaster recovery and high availability solutions',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
