import 'package:flutter/material.dart';
import 'package:simple_todo_app/screens/home_screen.dart';
import 'signup_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
   final usernameController =   TextEditingController();
   final passwordController = TextEditingController();
  // ... Similar structure as SignupScreen ... 

  // void _submitSigninForm() {
  //    if (_formKey.currentState!.validate()) { // Now you can use _formKey
  //     // TODO: Implement signin logic 
  //   }
    
  // }
    void displayError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(25.0), 
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, size: 50), 
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
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () async { // Make onPressed async
                          if (_formKey.currentState!.validate()) {
                            // Your form submission logic here (e.g., send data to the backend)
                            // ...
                            final password = passwordController.text;
                            final user = usernameController.text;
                            try {
                                final response = await http.post(
                                  Uri.parse('$backendUrl/signin'), // Create a '/signin' route in your backend
                                  headers: {'Content-Type': 'application/json'}, 
                                  body: jsonEncode({ 
                                    'username': usernameController.text,
                                    'password': passwordController.text 
                                  })
                                );

                                if (response.statusCode == 200) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeScreen(user, user: user,)), 
                                  );
                                } else if (response.statusCode == 401) { // Example for 401 Unauthorized
                                    displayError('Invalid username or password.');
                                } else {
                                  displayError('An error occurred. Please try again.');
                                }
                              } catch (error) {
                                displayError('An error occurred. Please try again.'); 
                              }
                            // Assuming your form submission is successful: 
                            
                          } 
                        }, 
                        child: Text('Sign In'),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the text
                        children: [
                          Text("New User? "), 
                          TextButton( 
                            onPressed: () {
                              Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => SignupScreen()),
                              );
                            },
                            child: Text("Sign Up"),
                          ),
                        ],
                      )
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
