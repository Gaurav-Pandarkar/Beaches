import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'profile_screen.dart'; // Import the ProfileScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late GoogleMapController mapController;
  String? username;
  String? mobileNo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      username = args['username'];
      mobileNo = args['mobileNo'];
    }
  }

  // Initial map position (centered on India)
  final LatLng _initialPosition = const LatLng(20.5937, 78.9629);

  // Function to handle map creation
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Function to handle navigation
  void _onItemTapped(int index) {
    if (index == 3) {
      // Navigate to ProfileScreen when Profile tab is clicked
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            username: username,
            mobileNo: mobileNo,
          ),
        ),
        //  MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else if (index == 1) {
      // Navigate to AvailableBeachesScreen when Available Beaches tab is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AvailableBeachesScreen()),
      );
    } else if (index == 2) {
      // Navigate to SearchScreen when Search tab is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchScreen()),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.blue[800],
          automaticallyImplyLeading: false,
          elevation: 6,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/beach.png',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Beach Buzz',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Explore the Best Beaches',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 5.0,
          ),
          markers: {
            Marker(
              markerId: MarkerId("india"),
              position: _initialPosition,
              infoWindow: InfoWindow(
                title: "India",
                snippet: "Explore the best beaches!",
              ),
            ),
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.beach_access),
              label: 'Available Beaches',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue[800],
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String? username;
  final String? mobileNo;

  ProfileScreen({this.username, this.mobileNo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30), // Spacing from top
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                "https://www.pngrepo.com/png/39708/512/farmer.png",
              ), // Hardcoded profile image
            ),
          ),
          SizedBox(height: 15), // Spacing
          Text(
            username ?? "John Doe", // User's name
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "Software Engineer | Flutter Developer", // User's profession
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 20),
          Divider(thickness: 1, indent: 30, endIndent: 30),
          SizedBox(height: 10),

          // User Information Section
          _buildInfoRow(Icons.email, "Email", "johndoe@example.com"),
          _buildInfoRow(Icons.phone, "Phone",
              mobileNo != null ? "+91 $mobileNo" : "+91 9876543210"),
          _buildInfoRow(Icons.location_on, "Location", "Mumbai, India"),

          Spacer(), // Pushes the logout text to the bottom
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
              onTap: () {
                // Handle logout logic here
                Navigator.pop(context);
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // Only red text, no button background
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build each info row
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[800]),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AvailableBeachesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Beaches"),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildBeachCard(
            "Alibagh Beach",
            "A very flat stretch makes for a long walk.",
            "assets/alibagh.png", // Replace with your image asset
          ),
          _buildBeachCard(
            "Mandawa Beach",
            "Mandava is a beautiful, untrodden beach. On a clear day, one can enjoy the serene views.",
            "assets/mandawa.png", // Replace with your image asset
          ),
          _buildBeachCard(
            "Harihareshwar Beach",
            "Gentle winds, soft sands, and inviting waters make Shrivanthan Bay a perfect destination.",
            "assets/harihareshwar.png", // Replace with your image asset
          ),
          _buildBeachCard(
            "Kashid Beach",
            "This is the main beach. A very flat stretch makes for a long walk.",
            "assets/kashid.png", // Replace with your image asset
          ),
        ],
      ),
    );
  }

  // Helper method to build a beach card
  Widget _buildBeachCard(String title, String description, String imagePath) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imagePath,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Beach"),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Explore Beaches Here",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Search Beach where you",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
