import 'package:flutter/material.dart';
import 'titles.dart';

class ProfileScreen extends StatelessWidget {
  final Titles titles;
  const ProfileScreen({Key? key, required this.titles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles.profileTitle),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/58616351?v=4',
              ),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),
            Text(
              'Manikanta',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Flutter Developer | Blogger',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
