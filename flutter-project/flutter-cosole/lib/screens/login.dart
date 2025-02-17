import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _boxAnimation;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoggingIn = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _logoAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _boxAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoggingIn = true;
    });

    final url = Uri.parse(
        'https://4d06-2409-40c2-1168-b4f3-ad8c-5673-f018-42cd.ngrok-free.app/api/v1/user/login');
    final Map<String, String> requestPayload = {
      'username': _usernameController.text,
      'password': _passwordController.text,
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestPayload),
      );

      if (response.statusCode == 200) {
        //Navigator.pushNamed(context, '/home');

        final Map<String, dynamic> responseData = json.decode(response.body);
        final String username = responseData['username'];
        final String mobileNo = responseData['mobileNo'];

        // Navigate to HomeScreen and pass the username and mobileNo
        Navigator.pushNamed(
          context,
          '/home',
          arguments: {
            'username': username,
            'mobileNo': mobileNo,
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please try again.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),

                // Logo with Animation
                ScaleTransition(
                  scale: _logoAnimation,
                  child: Center(
                    child: Image.asset(
                      'assets/beach.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                // Login Box and Fields
                FadeTransition(
                  opacity: _boxAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        Text(
                          'Beach Buzz',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        SizedBox(height: 30),

                        // Username Field
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person, color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Password Field
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock, color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Remember Me Checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (value) {},
                            ),
                            Text('Remember me'),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Login Button
                        ElevatedButton(
                          onPressed: _isLoggingIn ? null : _login,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade700,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                          child: _isLoggingIn
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        SizedBox(height: 20),

                        // Sign Up Text
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            "Not a member? Sign up",
                            style: TextStyle(
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Privacy Policy Text
                TextButton(
                  onPressed: () {
                    // Navigate to privacy policy screen
                  },
                  child: Text(
                    'Privacy policy',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
