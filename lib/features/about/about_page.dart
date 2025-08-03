import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '👋 Hey there! I\'m Gopi Manikanta',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Building scalable systems that handle high-volume traffic while optimizing for performance and reliability',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            Text(
              'Software Engineer II at Circleapp Online Services with 3+ years of hands-on experience',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Performance Optimization: Reduced API response times by 200ms through CDN integration',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Scale: Developed high-throughput real-time messaging systems',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Multi-Cloud Expert: Proficient across AWS, GCP, and Azure platforms',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Current Focus:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('- Building robust CI/CD pipelines with GitOps, Kubernetes & Terraform'),
            Text('- Architecting microservices for high-scale social media platforms'),
            Text('- Flutter mobile development experience'),
            Text('- Implementing disaster recovery and high availability solutions'),
          ],
        ),
      ),
    );
  }
}
