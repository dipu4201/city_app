import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart'; // Import the marquee package

class TouristAttractionsPage extends StatelessWidget {
  final List<Map<String, dynamic>> touristSpots = [
    {
      'name': 'Puthia Temple Complex',
      'distance': 23.0, // Distance in kilometers
      'rickshawFare': 150,
      'autoFare': 100,
      'icon': Icons.temple_hindu,
    },
    {
      'name': 'Barendra Museum',
      'distance': 2.5,
      'rickshawFare': 20,
      'autoFare': 15,
      'icon': Icons.museum,
    },
    {
      'name': 'Padma River Bank',
      'distance': 5.0,
      'rickshawFare': 40,
      'autoFare': 30,
      'icon': Icons.water,
    },
    {
      'name': 'Bangladesh Railway Station',
      'distance': 1.8,
      'rickshawFare': 15,
      'autoFare': 10,
      'icon': Icons.train,
    },
  ];

  TouristAttractionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourist Attractions"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Scrolling Announcement Banner
          Container(
            height: 50, // Height for the banner
            color: Colors.teal.shade100,
            child: Marquee(
              text: 'আমাদের সকল ভাড়া ও রাস্তার দূরত্ব রাজশাহী রেলগেট থেকে শুরু হয়!',
              style: const TextStyle(
                fontSize: 18, // Increased text size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              scrollAxis: Axis.horizontal, // Scroll horizontally
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 100.0, // Spacing between repetitions
              velocity: 50.0, // Speed of scrolling
              pauseAfterRound: const Duration(seconds: 2),
              showFadingOnlyWhenScrolling: false,
              fadingEdgeStartFraction: 0.1,
              fadingEdgeEndFraction: 0.1,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: touristSpots.length,
              itemBuilder: (context, index) {
                final spot = touristSpots[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(
                      spot['icon'],
                      size: 40,
                      color: Colors.teal,
                    ),
                    title: Text(
                      spot['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Distance from Rajshahi Railgate: ${spot['distance']} km',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rickshaw Fare: ৳${spot['rickshawFare']} (approx.)',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Auto Fare: ৳${spot['autoFare']} (approx.)',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.teal,
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Explore ${spot['name']}!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
