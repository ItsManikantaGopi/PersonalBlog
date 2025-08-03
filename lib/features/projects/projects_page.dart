import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  final List<Map<String, String>> projects = const [
    {
      'name': 'Real-time Messaging System',
      'impact': 'High-throughput message handling',
      'tech': 'WebSockets, Socket.IO, Redis',
    },
    {
      'name': 'Social Media Features',
      'impact': 'High-impact user engagement',
      'tech': 'NestJS, Flutter, AWS',
    },
    {
      'name': 'CI/CD Pipeline',
      'impact': 'Automated deployments',
      'tech': 'Kubernetes, Terraform, GitOps',
    },
    {
      'name': 'Video Processing Lambda',
      'impact': 'Serverless video handling',
      'tech': 'AWS Lambda, Python',
    },
    {
      'name': 'Performance Optimization',
      'impact': '200ms faster API responses',
      'tech': 'CDN, Gzip compression',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Projects'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: projects.length,
        separatorBuilder: (_, __) => const Divider(height: 32),
        itemBuilder: (context, index) {
          final project = projects[index];
          return Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project['name']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Impact: ${project['impact']}'),
                  Text('Tech Stack: ${project['tech']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
