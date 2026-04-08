import 'package:flutter/material.dart';
import 'views/splash.dart';
import 'views/login.dart';
import 'views/home.dart';
import 'views/partner.dart';
import 'views/memories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripSnap',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      
      home: const SplashScreen(),
    
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/partner': (context) => const PartnerScreen(),
        '/memories': (context) => const MemoriesScreen(),
      },
    );
  }
}
