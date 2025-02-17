import 'package:ai_crop_disease_system/screens/login.dart';
import 'package:flutter/material.dart';

class StartApplication extends StatefulWidget {
  @override
  _StartApplicationState createState() => _StartApplicationState();
}

class _StartApplicationState extends State<StartApplication>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Navigate to the login screen after 7 seconds with a smooth transition
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide in from the right
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            final offsetAnimation = tween.animate(curvedAnimation);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    });

    // Animation for the logo
    _controller = AnimationController(
      duration: Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo GIF with animation (placed above the heading)
                ScaleTransition(
                  scale: _animation,
                  child: Image.asset(
                    'assets/beach_loader.gif', // Using the GIF from assets
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20), // Add spacing between GIF and text

                // WELCOME Text
                Text(
                  'WELCOME',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
                SizedBox(height: 10), // Add spacing between the two text lines

                // BEACH BUZZ Text
                Text(
                  'BEACH BUZZ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
