import 'package:flutter/material.dart';
import '../home_screen.dart'; // Ensure path is correct
import 'map_screen.dart';
import 'profile_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex; // Track the initial tab index

  const CustomBottomNavBar({super.key, this.currentIndex = 0});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _selectedIndex; // Current selected index

  // List of pages for each tab
  final List<Widget> _pages = [
    const HomeScreen(), // Home page
    const MapScreen(),  // Map page
    const ProfileScreen(), // Profile page
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex; // Initialize with passed index
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index on tap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // Handle tab change
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
