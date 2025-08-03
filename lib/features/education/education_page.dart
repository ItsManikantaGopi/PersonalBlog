import 'package:flutter/material.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education & Certifications'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('🎓 B.Tech in Computer Science - Rajiv Gandhi University of Knowledge Technologies (2022)', style: TextStyle(fontSize: 18)),
            Text('GPA: 9.3/10.0'),
            SizedBox(height: 16),
            Text('🏆 Pre-University Course (MPC) - RGUKT (2018)', style: TextStyle(fontSize: 18)),
            Text('GPA: 8.4/10.0'),
          ],
        ),
      ),
    );
  }
}
