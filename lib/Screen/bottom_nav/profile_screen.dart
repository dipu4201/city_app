// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:rajshai_town/auth/auth_sevices.dart';
// import 'package:rajshai_town/auth/login_page.dart';
// import 'package:rajshai_town/widget/custom_appbar.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }
//
//   Future<void> _loadUserProfile() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       _emailController.text = user.email ?? '';
//       _nameController.text = user.displayName ?? 'No name set';
//     }
//   }
//
//   Future<void> _logout() async {
//     try {
//       await AuthService().signOut();
//       Get.offAll(() => LoginPage());
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Successfully logged out!")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Logout failed: $e")),
//       );
//     }
//   }
//
//   void _navigateToFeature(String feature) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Navigate to $feature")),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: const CustomAppBar(),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildUserCard(),
//             const SizedBox(height: 20),
//             _sectionHeader('E-commerce Features'),
//             const SizedBox(height: 10),
//             _buildFeatureCards(),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildUserCard() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const Icon(Icons.perm_identity_sharp, size: 80, color: Colors.teal),
//             const SizedBox(height: 10),
//             Text(
//               _nameController.text,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               _emailController.text,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFeatureCards() {
//     return Column(
//       children: [
//         _featureCard(
//           icon: Icons.shopping_cart,
//           title: 'My Orders',
//           subtitle: 'View your order history',
//           onTap: () => _navigateToFeature('My Orders'),
//         ),
//         _featureCard(
//           icon: Icons.favorite,
//           title: 'Saved Items',
//           subtitle: 'View your wishlist',
//           onTap: () => _navigateToFeature('Saved Items'),
//         ),
//         _featureCard(
//           icon: Icons.settings,
//           title: 'Account Settings',
//           subtitle: 'Manage your account settings',
//           onTap: () => _navigateToFeature('Account Settings'),
//         ),
//         _featureCard(
//           icon: Icons.logout,
//           title: 'Logout',
//           subtitle: 'Sign out from the app',
//           onTap: _logout,
//           iconColor: Colors.red,
//         ),
//       ],
//     );
//   }
//
//   Widget _featureCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//     Color iconColor = Colors.teal,
//   }) {
//     return Card(
//       elevation: 3,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: iconColor.withOpacity(0.2),
//           child: Icon(icon, color: iconColor),
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           subtitle,
//           style: const TextStyle(color: Colors.grey, fontSize: 14),
//         ),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: onTap,
//       ),
//     );
//   }
//
//   Widget _sectionHeader(String title) {
//     return Text(
//       title,
//       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rajshai_town/auth/auth_sevices.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _auth.getProfile();
      setState(() {
        _nameController.text = profile['name'] ?? '';
        _emailController.text = profile['email'] ?? '';
        _avatarUrl = profile['avatar_url'];
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> _updateProfile() async {
    try {
      await _auth.updateProfile(
        name: _nameController.text,
        email: _emailController.text,
        avatarUrl: _avatarUrl,
      );
      await _loadProfile();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    try {
      // Create a File instance using the picked file's path
      final file = File(pickedFile.path);
      final filePath = 'avatars/${user.id}/${DateTime.now().millisecondsSinceEpoch}';

      final storageResponse = await Supabase.instance.client.storage
          .from('avatars')
          .upload(filePath, file);

      if (storageResponse.error != null) {
        throw storageResponse.error!.message;
      }

      final imageUrl = Supabase.instance.client.storage
          .from('avatars')
          .getPublicUrl(filePath);

      setState(() => _avatarUrl = imageUrl);
      await _updateProfile();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _uploadImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _avatarUrl != null
                    ? NetworkImage(_avatarUrl!)
                    : null,
                child: _avatarUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('Save Profile'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _auth.signOut,
              child: const Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on String {
  get error => null;
}
