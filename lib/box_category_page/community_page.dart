import 'package:flutter/material.dart';
import 'package:rajshai_town/widget/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityPage extends StatelessWidget {
  // URLs for social media pages
  final String facebookUrl = 'https://www.facebook.com/Delower.Hossain42';
  final String instagramUrl = 'https://www.instagram.com/delower420.420/profilecard/?igsh=MXc0M3VmcW9odzhobQ==';
  final String websiteUrl = 'https://alvyit.live/developerDipu/';
  final String email = 'mailto:delowerdipu420@gmail.com';
  final String locationUrl = 'https://www.google.com/maps/search/?api=1&query=Rajshahi+Court';

  // Function to open URLs
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Join Our Community!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Connect with amazing people in Rajshahi and stay updated with events, activities, and more.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            Center(
              child: Image.asset(
                'assets/images/hotel/Community.png',
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // Social Media Section
            const Text(
              "Follow us on:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _socialButton(
                  icon: Icons.facebook,
                  label: "Facebook",
                  color: Colors.blue,
                  onTap: () => _launchURL(facebookUrl),
                ),
                _socialButton(
                  icon: Icons.photo_camera,
                  label: "Instagram",
                  color: Colors.purple,
                  onTap: () => _launchURL(instagramUrl),
                ),
                _socialButton(
                  icon: Icons.web,
                  label: "Website",
                  color: Colors.green,
                  onTap: () => _launchURL(websiteUrl),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Contact Section
            const Text(
              "Contact Us:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.red),
              title: const Text("Email Support"),
              onTap: () => _launchURL(email),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.orange),
              title: const Text("Find Us on Google Maps"),
              onTap: () => _launchURL(locationUrl),
            ),
            const SizedBox(height: 24),

            // Join Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thanks for joining!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text(
                    "Join Our Community",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Helper widget for social buttons
  Widget _socialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
