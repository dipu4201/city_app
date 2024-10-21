import 'package:flutter/material.dart';

class TouristAttractionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourist Attractions"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          "Explore popular tourist spots in Rajshahi City!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
