import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rajshai_town/app.dart';
import 'package:rajshai_town/cart_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://dyiqtulauqrxgjgtqzyl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR5aXF0dWxhdXFyeGdqZ3RxenlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk3MDE4OTYsImV4cCI6MjA1NTI3Nzg5Nn0.AiZ80Ck-OUwI9nMzxRJc5en_Ykjpd3LclBFhQwlglg4',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
