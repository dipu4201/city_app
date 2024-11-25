import 'package:flutter/material.dart';
import 'package:rajshai_town/widget/custom_appbar.dart';

class DiningPage extends StatelessWidget {

  BuildContext? _context;

  @override
  Widget build(BuildContext context) {

    _context = context;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          _buildHeroBanner(),
          const SizedBox(height: 16),
          _buildDiningCategoryGrid(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Reservation button action
          _showSnackBar('Reservation feature coming soon!');
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.restaurant_menu),
        label: const Text('Reserve Table'),
      ),
    );
  }

  // Getter for context
  BuildContext get context => _context!;

  // Helper function to show SnackBars safely
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Hero Banner Widget
  Widget _buildHeroBanner() {
    return SizedBox(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/dining.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey,
                alignment: Alignment.center,
                child: const Text(
                  'Banner image not available',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.black54,
            child: const Text(
              "Discover Fine Dining Experiences",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiningCategoryGrid() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildCategoryCard(Icons.local_pizza, "Pizza"),
            _buildCategoryCard(Icons.ramen_dining, "Ramen"),
            _buildCategoryCard(Icons.coffee, "Coffee"),
            _buildCategoryCard(Icons.fastfood, "Burgers"),
            _buildCategoryCard(Icons.icecream, "Desserts"),
            _buildCategoryCard(Icons.wine_bar, "Drinks"),
          ],
        ),
      ),
    );
  }


  Widget _buildCategoryCard(IconData icon, String label) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      color: Color(0xFF1991B7),
      child: InkWell(
        onTap: () {
          _showSnackBar('Explore $label');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.orange),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
