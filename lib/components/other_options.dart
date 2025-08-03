import 'package:flutter/material.dart';
import 'titles.dart';

class OtherScreen extends StatelessWidget {
  final Titles titles;
  const OtherScreen({Key? key, required this.titles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles.otherTitle),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Other information will be shown here.',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
