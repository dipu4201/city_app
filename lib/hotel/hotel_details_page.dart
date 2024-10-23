import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rajshai_town/cart_provider.dart';

class HotelDetailPage extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const HotelDetailPage({required this.hotel});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(hotel['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    hotel['image'],
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.favorite_border, color: Colors.redAccent),
                    label: const Text('Save', style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Hotel saved to favorites!')),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel['name'],
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(hotel['description'], style: const TextStyle(fontSize: 18, color: Colors.black54)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 22),
                      const SizedBox(width: 6),
                      Text(
                        hotel['rating'].toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        hotel['category'],
                        style: TextStyle(
                          fontSize: 16,
                          color: hotel['category'] == "Luxury"
                              ? Colors.green
                              : (hotel['category'] == "Medium" ? Colors.blue : Colors.red),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.hotel, color: Colors.teal, size: 24),
                      const SizedBox(width: 8),
                      Text("${hotel['availableRooms']} rooms available", style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart, color: Colors.white),
                      label: const Text('Add to Cart', style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        _showRoomSelectionDialog(context, cartProvider);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRoomSelectionDialog(BuildContext context, CartProvider cartProvider) {
    int selectedRooms = 1; // Default selected room
    final int roomPrice = 5000; // Price per room

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Rooms', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Each room costs 5000 BDT', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: () {
                      if (selectedRooms > 1) {
                        selectedRooms--;
                      }
                      (context as Element).markNeedsBuild(); // Rebuild the dialog
                    },
                  ),
                  Text(
                    '$selectedRooms',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                    onPressed: () {
                      selectedRooms++;
                      (context as Element).markNeedsBuild(); // Rebuild the dialog
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Total: ${roomPrice * selectedRooms} BDT',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Add to Cart'),
              onPressed: () {
                final hotelWithRooms = {
                  ...hotel,
                  'rooms': selectedRooms,
                  'totalPrice': roomPrice * selectedRooms, // Correctly adding totalPrice
                };
                cartProvider.addToCart(hotelWithRooms);

                Navigator.pop(context); // Close dialog

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${hotel['name']} added with $selectedRooms room(s)!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
