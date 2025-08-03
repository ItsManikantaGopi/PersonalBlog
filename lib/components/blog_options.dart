import 'package:flutter/material.dart';
import 'titles.dart';

class BlogScreen extends StatelessWidget {
  final Titles titles;
  const BlogScreen({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles.blogTitle),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Welcome to the Blog section!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
