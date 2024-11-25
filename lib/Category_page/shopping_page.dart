import 'package:flutter/material.dart';
import 'package:rajshai_town/widget/custom_appbar.dart';

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          _buildPromotionalSlider(),
          const SizedBox(height: 16),
          _buildCategorySection(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Safe snack bar usage with context
          _showSnackBar(context, 'Go to Cart');
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  // Helper method to show a SnackBar safely
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Promotional Slider Widget
  Widget _buildPromotionalSlider() {
    return SizedBox(
      height: 180,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildSliderCard("assets/images/big_sale.jpg", "Big Sale - Up to 50% OFF!"),
          _buildSliderCard("assets/images/new_arrival.jpeg", "New Arrivals Just Landed!"),
          _buildSliderCard("assets/images/fashion.jpg", "Upgrade Your Style Today"),
        ],
      ),
    );
  }

  // Slider Card with null-safe image asset handling
  Widget _buildSliderCard(String imagePath, String caption) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback in case the asset path is incorrect or missing
                return Container(
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: const Text(
                    'Image not found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Text(
                caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Category Grid Section
  Widget _buildCategorySection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildCategoryCard(Icons.phone_android, "Electronics"),
            _buildCategoryCard(Icons.local_grocery_store, "Groceries"),
            _buildCategoryCard(Icons.chair, "Furniture"),
            _buildCategoryCard(Icons.shopping_bag, "Clothing"),
            _buildCategoryCard(Icons.watch, "Watches"),
            _buildCategoryCard(Icons.home, "Home Decor"),
          ],
        ),
      ),
    );
  }

  // Category Card with Safe Tap Handling
  Widget _buildCategoryCard(IconData icon, String label) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: InkWell(
        onTap: () {
          // Handle category tap safely
          // Example: Navigate to another page or show a message
          debugPrint('Navigating to $label');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.teal),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
