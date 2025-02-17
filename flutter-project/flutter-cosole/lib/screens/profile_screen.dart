import 'package:flutter/material.dart';

class FarmerProfileScreen extends StatefulWidget {
  const FarmerProfileScreen({Key? key}) : super(key: key);

  @override
  _FarmerProfileScreenState createState() => _FarmerProfileScreenState();
}

class _FarmerProfileScreenState extends State<FarmerProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    // Define a fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Profile'),
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Add logout functionality here
              print('User logged out');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Farmer Profile Card
                _buildProfileCard(),
                SizedBox(height: 20),
                // Additional Information Cards
                _buildInfoCard(
                    'Crops Grown', 'Wheat, Corn, Soybean', Icons.grain),
                _buildInfoCard('Farm Size', '25 acres', Icons.landscape),
                _buildInfoCard('Recent Activities', 'Planted new wheat seeds',
                    Icons.update),
                _buildInfoCard('Soil Quality', 'Loamy, pH: 6.5', Icons.grass),
                _buildInfoCard(
                    'Weather Condition', 'Sunny, 30°C', Icons.wb_sunny),
                _buildInfoCard(
                    'Irrigation System', 'Drip irrigation', Icons.water),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildEditProfileButton(),
    );
  }

  // Function to build the farmer's profile card
  Widget _buildProfileCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Hero(
              tag: 'farmerProfile',
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/farmer.png'), // Hardcoded profile picture
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe', // Hardcoded name
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Farmer since 2010', // Hardcoded information
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Location: Springfield', // Hardcoded information
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build additional information cards
  Widget _buildInfoCard(String title, String info, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Add functionality on tap (e.g., navigate to a detailed page)
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: ListTile(
            leading: Icon(icon, size: 40, color: Colors.blue.shade600),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            subtitle: Text(
              info,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to build the Edit Profile button
  Widget _buildEditProfileButton() {
    return ScaleTransition(
      scale: Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      )),
      child: FloatingActionButton(
        onPressed: () {
          // Add functionality for editing the profile
        },
        backgroundColor: Colors.blue.shade600,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Icon(Icons.edit, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
