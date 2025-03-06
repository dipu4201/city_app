import 'package:flutter/material.dart';
import 'package:rajshai_town/Screen/bottom_nav/bottom_nav_bar.dart';
import 'package:rajshai_town/auth/auth_sevices.dart';
import 'package:rajshai_town/auth/shared_pref_service.dart';
import 'package:rajshai_town/auth/sign_up_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final user = await AuthService().signInWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (user == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid credentials'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        ),
      );
    } else {
      // Store login details
      await SharedPrefService.saveUserLogin(_emailController.text.trim());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CustomBottomNavBar()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter email' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter password' : null,
                      ),
                      const SizedBox(height: 24),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo, // Button background color
                            foregroundColor: Colors.white, // Text color
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 90),
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4, // Subtle shadow for a premium feel
                            shadowColor: Colors.black45,
                          ),
                          child: const Text('Log In'),
                          onPressed: _submit,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.indigo, padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 90),
                          backgroundColor: Colors.white, // For the text color.
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.indigo, width: 1),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Create Account'),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        ),
                      ),
                      const Divider(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white54,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          // Use an asset image for the Google logo.
                          icon: Image.asset(
                            'assets/logo/google.png',
                            height: 24,
                            width: 24,
                          ),
                          label: const Text('Sign In with Google'),
                          onPressed: () async {
                            setState(() => _isLoading = true);
                            final user = await AuthService().signInWithGoogle();
                            setState(() => _isLoading = false);
                            if (user != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CustomBottomNavBar(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
