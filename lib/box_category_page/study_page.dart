import 'package:flutter/material.dart';

class StudyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Opportunities"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCoachingCard(
              context,
              title: "Varsity Admission Coaching",
              description: "Get expert guidance for university admissions.",
              imagePath: "assets/images/study/varsity.png",
            ),
            _buildCoachingCard(
              context,
              title: "HSC Coaching",
              description: "Comprehensive coaching for intermediate students.",
              imagePath: "assets/images/study/hsc.jpg",
            ),
            _buildCoachingCard(
              context,
              title: "ICT Courses",
              description: "Learn English and other languages to enhance your skills.",
              imagePath: "assets/images/study/ict.jpg",
            ),
            // Add more coaching cards as needed
          ],
        ),
      ),
    );
  }

  Widget _buildCoachingCard(BuildContext context,
      {required String title, required String description, required String imagePath}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('More information about $title!'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
