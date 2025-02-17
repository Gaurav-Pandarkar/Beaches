// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http; // Import the http package
// import 'dart:convert'; // For encoding and decoding JSON
// import 'login.dart'; // Make sure to create this screen

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _boxAnimation;

//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isMobileValid = true;
//   bool _isRegistering = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..forward();

//     _logoAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );

//     _boxAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _usernameController.dispose();
//     _mobileController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   bool _validateMobileNumber(String input) {
//     final RegExp mobileRegExp = RegExp(r'^[6-9]\d{9}$');
//     return mobileRegExp.hasMatch(input);
//   }

//   // Function to handle user registration
//   Future<void> _registerUser() async {
//     setState(() {
//       _isRegistering = true;
//     });

//     final String username = _usernameController.text.trim();
//     final String mobileNo = _mobileController.text.trim();
//     final String password = _passwordController.text.trim();

//     // Validate input fields
//     if (username.isEmpty ||
//         !_validateMobileNumber(mobileNo) ||
//         password.isEmpty) {
//       setState(() {
//         _isMobileValid = _validateMobileNumber(mobileNo);
//         _isRegistering = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please fill in all fields correctly.'),
//         ),
//       );
//       return;
//     }

//     final url = Uri.parse('http://192.168.16.193:8080/api/v1/user/register');

//     // Create the request payload
//     final Map<String, String> requestPayload = {
//       'username': username,
//       'mobileNo': mobileNo,
//       'password': password,
//     };

//     try {
//       // Make the POST request
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(requestPayload),
//       );

//       if (response.statusCode == 200) {
//         // Successful registration
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Registration successful!'),
//           ),
//         );

//         // Navigate to Login screen
//         if (mounted) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => LoginScreen(),
//             ),
//           );
//         }
//       } else {
//         // Failed registration
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Registration failed. ${response.body}'),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//         ),
//       );
//     } finally {
//       setState(() {
//         _isRegistering = false; // Hide loading indicator
//       });
//     }
//   }

//   void _navigateToLogin() {
//     if (mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     }
//   }

//   bool _isAllFieldsValid() {
//     return _usernameController.text.trim().isNotEmpty &&
//         _validateMobileNumber(_mobileController.text.trim()) &&
//         _passwordController.text.trim().isNotEmpty;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.white, // Updated background color
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const ClampingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.1),

//                 // Logo with Animation
//                 ScaleTransition(
//                   scale: _logoAnimation,
//                   child: Center(
//                     child: Image.asset(
//                       'assets/beach.png',
//                       height: 120,
//                       width: 120,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05),

//                 // Sign Up Text Centered
//                 Text(
//                   'Sign Up',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue.shade900,
//                   ),
//                 ),
//                 SizedBox(height: 30),

//                 // Sign Up Box and Fields
//                 FadeTransition(
//                   opacity: _boxAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Username Field
//                         TextField(
//                           controller: _usernameController,
//                           decoration: InputDecoration(
//                             labelText: 'Username',
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.person, color: Colors.blue),
//                           ),
//                           onChanged: (input) {
//                             setState(() {}); // Check if fields are valid
//                           },
//                         ),
//                         SizedBox(height: 20),

//                         // Mobile Number Field
//                         TextField(
//                           controller: _mobileController,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             labelText: 'Mobile Number',
//                             errorText:
//                                 _isMobileValid ? null : 'Invalid mobile number',
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.phone, color: Colors.blue),
//                           ),
//                           onChanged: (input) {
//                             setState(() {
//                               _isMobileValid = _validateMobileNumber(input);
//                             }); // Check if fields are valid
//                           },
//                         ),
//                         SizedBox(height: 20),

//                         // Password Field
//                         TextField(
//                           controller: _passwordController,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.lock, color: Colors.blue),
//                           ),
//                           onChanged: (input) {
//                             setState(() {}); // Check if fields are valid
//                           },
//                         ),
//                         SizedBox(height: 20),

//                         // Register Button
//                         ElevatedButton(
//                           onPressed: _isAllFieldsValid() && !_isRegistering
//                               ? _registerUser
//                               : null,
//                           style: ElevatedButton.styleFrom(
//                             primary: _isAllFieldsValid()
//                                 ? Colors.blue.shade700
//                                 : Colors.blue.shade400, // Change button color
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                           ),
//                           child: _isRegistering
//                               ? CircularProgressIndicator(
//                                   color: Colors.white,
//                                 )
//                               : Text(
//                                   'Register',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                         ),
//                         SizedBox(height: 20),

//                         // Already have an Account? Navigate to Login
//                         TextButton(
//                           onPressed: _navigateToLogin,
//                           child: Text(
//                             "Already have an account? Login",
//                             style: TextStyle(
//                               color: Colors.blue.shade800,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 30), // Give some space before the skip button

//                 // Skip Button
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20.0),
//                   child: TextButton.icon(
//                     onPressed: () {
//                       // Navigate to /multilanguage screen
//                       if (mounted) {
//                         Navigator.pushNamed(context, '/multilanguage');
//                       }
//                     },
//                     icon: Icon(Icons.arrow_forward, color: Colors.blue),
//                     label: Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: Colors.blue.shade700,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart'; // Ensure this import points to your login screen
import 'home_screen.dart'; // Import the HomeScreen

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _boxAnimation;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isMobileValid = true;
  bool _isRegistering = false;

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
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateMobileNumber(String input) {
    final RegExp mobileRegExp = RegExp(r'^[6-9]\d{9}$');
    return mobileRegExp.hasMatch(input);
  }

  Future<void> _registerUser() async {
    if (_isRegistering) return;

    setState(() {
      _isRegistering = true;
    });

    final String username = _usernameController.text.trim();
    final String mobileNo = _mobileController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty ||
        !_validateMobileNumber(mobileNo) ||
        password.isEmpty) {
      setState(() {
        _isMobileValid = _validateMobileNumber(mobileNo);
        _isRegistering = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields correctly.'),
        ),
      );
      return;
    }

    final url = Uri.parse(
        'https://4d06-2409-40c2-1168-b4f3-ad8c-5673-f018-42cd.ngrok-free.app/api/v1/user/register');

    final Map<String, String> requestPayload = {
      'username': username,
      'mobileNo': mobileNo.toString(),
      'password': password,
    };

    try {
      print('Sending request to: $url');
      print('Request payload: ${json.encode(requestPayload)}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestPayload),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration successful!'),
          ),
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${response.body}'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isRegistering = false;
        });
      }
    }
  }

  void _navigateToLogin() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  bool _isAllFieldsValid() {
    return _usernameController.text.trim().isNotEmpty &&
        _validateMobileNumber(_mobileController.text.trim()) &&
        _passwordController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
                Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 30),
                FadeTransition(
                  opacity: _boxAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person, color: Colors.blue),
                          ),
                          onChanged: (input) {
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            errorText:
                                _isMobileValid ? null : 'Invalid mobile number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone, color: Colors.blue),
                          ),
                          onChanged: (input) {
                            setState(() {
                              _isMobileValid = _validateMobileNumber(input);
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock, color: Colors.blue),
                          ),
                          onChanged: (input) {
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _isAllFieldsValid() && !_isRegistering
                              ? _registerUser
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: _isAllFieldsValid()
                                ? Colors.blue.shade700
                                : Colors.blue.shade400,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: _isRegistering
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: _navigateToLogin,
                          child: Text(
                            "Already have an account? Login",
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextButton.icon(
                    onPressed: () {
                      if (mounted) {
                        // Navigate to HomeScreen when Skip is clicked
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                    },
                    icon: Icon(Icons.arrow_forward, color: Colors.blue),
                    label: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 16,
                      ),
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
