import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rajshai_town/profile_all/payment_methods_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image; // Variable to store the uploaded image
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController(text: 'Delower Hossain');
  final TextEditingController _emailController = TextEditingController(text: 'delowerdipu420@gmail.com');

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    var status = await Permission.storage.request(); // Request storage permission

    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        _showMessage('No image selected.');
      }
    } else {
      _showMessage('Permission to access storage was denied.');
    }
  }

  // Function to show messages using SnackBar
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Function to open edit profile dialog
  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Here you can handle additional logic if needed
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to Settings Page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const NetworkImage('https://via.placeholder.com/150')
                      as ImageProvider,
                      child: _image == null
                          ? const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white54,
                      )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // User Information
              Text(
                _nameController.text,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _emailController.text,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _actionButton(
                    icon: Icons.edit,
                    label: 'Edit Profile',
                    color: Colors.teal,
                    onTap: _showEditProfileDialog,
                  ),
                  const SizedBox(width: 16),
                  _actionButton(
                    icon: Icons.logout,
                    label: 'Logout',
                    color: Colors.red,
                    onTap: () {

                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Additional Options Section
              _sectionHeader('Account Settings'),
              const SizedBox(height: 10),
              _optionTile(
                title: 'Privacy Settings',
                icon: Icons.privacy_tip,
                onTap: () {

                },
              ),
              _optionTile(
                title: 'Notification Settings',
                icon: Icons.notifications,
                onTap: () {

                },
              ),
              _optionTile(
                title: 'Order History',
                icon: Icons.history,
                onTap: () {

                },
              ),
              _optionTile(
                title: 'Payment Methods',
                icon: Icons.payment,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentMethodsPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              _sectionHeader('Help & Support'),
              const SizedBox(height: 10),
              _optionTile(
                title: 'FAQs',
                icon: Icons.help_outline,
                onTap: () {

                },
              ),
              _optionTile(
                title: 'Contact Support',
                icon: Icons.phone_in_talk,
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for creating action buttons
  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(icon, size: 20, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }


  Widget _sectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }


  Widget _optionTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
