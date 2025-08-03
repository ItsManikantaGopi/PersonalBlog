import 'package:flutter/material.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({Key? key}) : super(key: key);

  final List<Map<String, String>> timeline = const [
    {
      'year': '2020-2021',
      'role': 'ML Intern',
      'company': 'Continual Engine',
      'desc': 'Image-to-text models, PyTorch & Autoencoders',
    },
    {
      'year': '2021-2022',
      'role': 'Software Developer Intern',
      'company': 'Circleapp Online Services',
      'desc': 'Revenue-generating features, Bug fixes & API development',
    },
    {
      'year': '2022-2025',
      'role': 'Software Engineer',
      'company': 'Circleapp Online Services',
      'desc': 'CI/CD & Infrastructure, Real-time systems, Multi-cloud deployments',
    },
    {
      'year': '2025-Present',
      'role': 'Software Engineer II',
      'company': 'Circleapp Online Services',
      'desc': 'Advanced system architecture, Performance optimization, Infrastructure automation',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experience Timeline'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: timeline.length,
        separatorBuilder: (_, __) => const Divider(height: 32),
        itemBuilder: (context, index) {
          final item = timeline[index];
          return ListTile(
            leading: CircleAvatar(child: Text(item['year']![0])),
            title: Text('${item['role']} - ${item['company']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${item['year']}\n${item['desc']}'),
          );
        },
      ),
    );
  }
}
