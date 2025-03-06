import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rajshai_town/Screen/bottom_nav/profile_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late StreamSubscription<User?> _authSubscription;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (mounted) {
          setState(
            () {
              _user = user;
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = _user?.email ?? 'Guest User';
    const location = 'Rajshahi, BD';

    return AppBar(
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // User Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Text(
                  location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 1,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          color: Colors.blueGrey,
          onPressed: () {
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
