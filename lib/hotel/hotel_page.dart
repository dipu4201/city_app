import 'package:flutter/material.dart';
import 'package:rajshai_town/hotel/hotel_details_page.dart';

class HotelsPage extends StatefulWidget {
  @override
  _HotelsPageState createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  final List<Map<String, dynamic>> hotels = [
    {
      "name": "Grand River View",
      "description": "A luxurious hotel with modern amenities and dining options.",
      "image": "assets/images/hotel/river_view.jpg",
      "rating": 4.8,
      "category": "Luxury",
    },
    {
      "name": "Hotel X",
      "description": "Comfortable rooms with city views and free breakfast.",
      "image": "assets/images/hotel/hotel_x.png",
      "rating": 4.5,
      "category": "Luxury",
    },
    {
      "name": "Aronno Resort",
      "description": "Known for its beautiful garden and excellent service.",
      "image": "assets/images/hotel/aronno_hotel.png",
      "rating": 4.8,
      "category": "Medium",
    },
    {
      "name": "Hotel Green City",
      "description": "Budget-friendly rooms with access to attractions.",
      "image": "assets/images/hotel/green_city.png",
      "rating": 3.9,
      "category": "Low",
    },
  ];

  String selectedCategory = "All";

  List<Map<String, dynamic>> get filteredHotels {
    if (selectedCategory == "All") return hotels;
    return hotels.where((hotel) => hotel['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotels in Rajshahi City"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ["All", "Luxury", "Medium", "Low"].map((category) {
                return CategoryButton(
                  title: category,
                  isSelected: selectedCategory == category,
                  onTap: () => setState(() => selectedCategory = category),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredHotels.length,
              itemBuilder: (context, index) {
                return HotelCard(hotel: filteredHotels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailPage(hotel: hotel),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                hotel['image'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel['name'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    hotel['description'],
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            hotel['rating'].toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelDetailPage(hotel: hotel),
                            ),
                          );
                        },
                        child: const Text("Details"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
