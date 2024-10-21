import 'package:flutter/material.dart';

class EventsFestivalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events & Festivals"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: const Text(
          "Discover exciting events and festivals happening in Rajshahi!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
