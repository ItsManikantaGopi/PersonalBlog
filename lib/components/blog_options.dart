import 'package:flutter/material.dart';
import 'titles.dart';

class BlogScreen extends StatelessWidget {
  final Titles titles;
  const BlogScreen({Key? key, required this.titles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles.blogTitle),
        backgroundColor: Colors.blue,
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
