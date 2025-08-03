import 'package:flutter/material.dart';
import 'titles.dart';

class WorkExperienceScreen extends StatelessWidget {
  final Titles titles;
  const WorkExperienceScreen({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles.workExperienceTitle,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Work Experience details will be shown here.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
