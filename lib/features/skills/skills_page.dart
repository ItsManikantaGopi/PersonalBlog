import 'package:flutter/material.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> skills = const [
    {
      'category': 'Languages',
      'items': ['Ruby', 'Python', 'Dart', 'TypeScript'],
    },
    {
      'category': 'Backend & APIs',
      'items': ['NestJS', 'Ruby on Rails', 'Node.js', 'Socket.io'],
    },
    {
      'category': 'Cloud & DevOps',
      'items': ['AWS', 'Google Cloud', 'Azure', 'Kubernetes', 'Docker'],
    },
    {
      'category': 'IaC & Config',
      'items': ['Terraform', 'YAML'],
    },
    {
      'category': 'Mobile',
      'items': ['Flutter'],
    },
    {
      'category': 'Databases & Caching',
      'items': ['MongoDB', 'MySQL', 'Redis'],
    },
    {
      'category': 'Monitoring & Analytics',
      'items': ['Grafana', 'Prometheus', 'New Relic'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Stack & Skills'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          final category = skills[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category['category'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: List<Widget>.from(
                  (category['items'] as List<String>).map((item) => Chip(label: Text(item))),
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
