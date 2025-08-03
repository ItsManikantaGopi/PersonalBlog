import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'Thanks for visiting!',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            "Let's build something amazing together",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          SizedBox(height: 8),
          Text(
            '⭐ From itsManikantaGopi - Building the future, one commit at a time!',
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
        ],
      ),
    );
  }
}
