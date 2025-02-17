import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/loader.gif',
        width: 100, // Adjust the size as per your needs
        height: 100,
      ),
    );
  }
}
