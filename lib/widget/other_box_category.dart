import 'package:flutter/material.dart';

Widget otherCategoryCard(IconData icon, String title, Color color, VoidCallback onTap) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 3,
    color: color.withOpacity(0.1),
    child: InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color), // Reduced size
          const SizedBox(height: 8), // Reduced spacing
          Text(
            title,
            style: TextStyle(
              fontSize: 14, // Reduced font size
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
