import 'package:flutter/material.dart';

class StudyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: const Text(
          "Learn about study opportunities in Rajshahi!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
