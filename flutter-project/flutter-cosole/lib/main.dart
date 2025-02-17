import 'package:ai_crop_disease_system/screens/login.dart';
import 'package:ai_crop_disease_system/screens/signup.dart';
import 'package:flutter/material.dart';
import 'screens/start_application.dart'; // Import the StartApplication widget
import 'screens/home_screen.dart'; // Import the HomeScreen widget
import 'screens/profile_screen.dart'; // Import Profile screen
import 'screens/taskbar.dart'; // Import Taskbar widget

void main() {
  runApp(MyApp());
}

// Main application class
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AI Crop Disease Prediction',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        // Set StartApplication as the initial screen
        home: StartApplication(),
        routes: {
          '/start': (context) => StartApplication(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => FarmerProfileScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
        });
  }
}
