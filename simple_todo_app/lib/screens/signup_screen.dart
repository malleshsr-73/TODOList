import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const backendUrl = 'http://localhost:8000'; 

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();

  
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController =   TextEditingController();// For form validation
  // ... TextEditingControllers for username, email, password ...  

  // void _submitSignupForm() {
  //   if (_formKey.currentState!.validate()) {
  //     // Extract password values (assume you have TextEditingControllers for each)
  //     final password = passwordController.text;
  //     final confirmPassword = confirmPasswordController.text;

  //     if (password != confirmPassword) {
  //       // Display an error message (We'll discuss how below)
  //       displayPasswordMismatchError(); 
  //       return; 
  //     }

  //     // If passwords match, proceed with your existing signup logic
  //     // ...
  //   }
  // }

  void displayPasswordMismatchError() {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Passwords didn\'t match')), 
  );
    // Implementation for displaying the error - see options below
  }
  void displaySignupError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Center(
        child: SingleChildScrollView( // Add for potential scrolling
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.grey[200], 
              child: Padding(
                padding: const EdgeInsets.all(25.0), 
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Keep card compact
                    children: [
                      Icon(Icons.person, size: 50), // Add an icon
                      SizedBox(height: 20),
                      TextFormField( 
                        decoration: InputDecoration(hintText: 'Username'),
                        controller: usernameController,
                        // ... (Add controller and validator) ... 
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(  // Add the eye icon here
                            icon: Icon(
                              _obscurePassword ? Icons.visibility : Icons.visibility_off
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword; 
                              });
                            },
                          ), 
                        ),
                        controller: passwordController,
                        obscureText: _obscurePassword, 
                        // ... other properties ... 
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(  // Add the eye icon here
                            icon: Icon(
                              _obscurePassword ? Icons.visibility : Icons.visibility_off
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword; 
                              });
                            },
                          ), 
                        ),
                        controller: confirmPasswordController,
                        obscureText: _obscurePassword, 
                        // ... other properties ... 
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () async { // Make onPressed async
                          if (_formKey.currentState!.validate()) {
                            // Extract password values
                            final password = passwordController.text;
                            final confirmPassword = confirmPasswordController.text;

                            if (password != confirmPassword) {
                              displayPasswordMismatchError(); 
                              return; 
                            }
                            try {
                               print('Username: ${usernameController.text}'); 
                                print('Password: ${passwordController.text}');
                              final response = await http.post(
                                Uri.parse('$backendUrl/signup'), 
                                headers: {'Content-Type': 'application/json'}, 
                                body: jsonEncode({
                                  'username': usernameController.text,
                                  'password': passwordController.text 
                                })
                              );
                              

                            if (response.statusCode == 200) {
                              Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => SigninScreen()), 
                                          );
                            } 
                            else {
                              displaySignupError('Signup failed. Please try again.');
                            }
                              print('Status Code: ${response.statusCode}'); // Debug
                              print('Response Body: ${response.body}');
                            } catch (error) {
              displaySignupError('An error occurred. Please try again. $error'); 
            }

                            // Your form submission logic here (e.g., send data to the backend)
                            // ...

                            // Assuming your form submission is successful: 
                            
                          } 
                        }, 
                        child: Text('Sign Up'),
                      ),
                      SizedBox(height: 20), // Optional spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already a user? "),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SigninScreen()),
                              );
                          },
                          child: Text("Sign In"),
                        ),
                      ],
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 