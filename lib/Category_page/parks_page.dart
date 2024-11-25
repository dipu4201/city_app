import 'package:flutter/material.dart';
import 'package:rajshai_town/widget/custom_appbar.dart';

class ParksPage extends StatelessWidget {
  final List<Map<String, String>> parks = [
    {
      "name": "Shahid Zia Park",
      "description": "A popular park known for its vibrant flower beds and seating areas.",
      "image": "assets/images/zia_park.jpg",
    },
    {
      "name": "Rajshahi City Park",
      "description": "A large park featuring a lake, gardens, and play areas for children.",
      "image": "assets/images/rajshahi_city_park.jpg", // Replace with your image asset path
    },
    {
      "name": "Shafina Park",
      "description": "A beautiful park with lush greenery and Picnic path.",
      "image": "assets/images/shafina_park.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView.builder(
        itemCount: parks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Park Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    parks[index]['image']!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    parks[index]['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    parks[index]['description']!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
