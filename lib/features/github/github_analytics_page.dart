import 'package:flutter/material.dart';

class GithubAnalyticsPage extends StatelessWidget {
  const GithubAnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Analytics'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Center(
            child: Column(
              children: [
                Image.network('https://github-readme-stats.vercel.app/api?username=itsManikantaGopi&show_icons=true&theme=tokyonight&include_all_commits=true&count_private=true'),
                const SizedBox(height: 16),
                Image.network('https://github-readme-stats.vercel.app/api/top-langs/?username=itsManikantaGopi&layout=compact&langs_count=8&theme=tokyonight'),
                const SizedBox(height: 16),
                Image.network('https://github-readme-streak-stats.herokuapp.com/?user=itsManikantaGopi&theme=tokyonight'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
