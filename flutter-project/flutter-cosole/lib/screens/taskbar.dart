import 'package:flutter/material.dart';

class Taskbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Taskbar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hard-coded names for each icon in the taskbar
    final List<String> itemNames = [
      'Home', // Name for the home icon
      'Notes', // Name for the self-notes icon
      'Agronomist', // Name for the agronomist icon
      'Profile', // Name for the profile icon
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Ensure labels are always shown
      backgroundColor: Color.fromARGB(255, 248, 249, 248),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/home.jpg', // Path to your home image in the assets folder
            height: 30,
          ),
          label: itemNames[0], // Use hard-coded name for Home
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/note.jpg', // Path to your self-notes image in the assets folder
            height: 30,
          ),
          label: itemNames[1], // Use hard-coded name for My Notes
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/agronomist.jpg', // Path to your agronomist image in the assets folder
            height: 30,
          ),
          label: itemNames[2], // Use hard-coded name for Consult Agronomist
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/userProfile.jpg', // Path to your profile image in the assets folder
            height: 30,
          ),
          label: itemNames[3], // Use hard-coded name for Profile
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey, // Optional: color for unselected items
      onTap: (index) {
        onTap(index); // Call the passed function with the index
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home'); // Navigate to Home
            break;
          case 1:
            Navigator.pushNamed(context, '/self_notes'); // Navigate to My Notes
            break;
          case 2:
            Navigator.pushNamed(
                context, '/agronomist'); // Navigate to Consult Agronomist
            break;
          case 3:
            Navigator.pushNamed(context, '/profile'); // Navigate to Profile
            break;
        }
      },
    );
  }
}
