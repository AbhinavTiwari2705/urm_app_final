import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:xml/xml.dart' as xml;
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

Future<void> login(String username, String password) async {
    try {
      // Define the URL where you want to send the login request
      const String loginUrl =
          'https://bspapp.sail-bhilaisteel.com/MES_MOB/APP/mesapp_login.jsp';

      // Create a Map with the parameters
      final Map<String, String> formData = {
        'userid': username,
        'password': password,
      };

      // Make a POST request to the login URL with the JSON-encoded payload
      final http.Response response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST,GET,OPTIONS",
          "Access-Control-Allow-Headers": "Content-Type,Accept, X-Requested-With"
          
        },
        body: json.encode(formData),
      );


      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print("Login Success");
        Navigator.pushNamed(context, '/homie');

        // Parse the JSON response
        final List<dynamic> responseData = json.decode(response.body);

        // Accessing elements in the JSON response
        final String name = responseData[0]['NAME'];
        final String status = responseData[0]['STATUS'];
        final String loginName = responseData[0]['LOGIN_NAME'];

        // Show a success dialog
        showDialog(
          context: context, // Make sure you have a valid context
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Success"),
              content:
                  Text("Name: $name\nStatus: $status\nLogin Name: $loginName"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        // If the request was not successful, print an error message
        print("Login Failed");
      }
    } catch (e) {
      // Handle any exceptions that might occur during the login process
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 33, 4, 176),
              Color.fromARGB(255, 236, 236, 237),
              Color.fromARGB(255, 6, 6, 249),
              Color.fromARGB(255, 236, 236, 237),
              Color.fromARGB(255, 4, 4, 234),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assests/images/logo.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 16.0),
                Text("U R M", 
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
                SizedBox(height: 16.0),
                // Username input field
                TextField(
                  controller: _usernameController,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Password input field
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                // Sign-in button
                ElevatedButton(
                  onPressed: () {
                    // Handle sign-in logic here
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    // Perform sign-in validation or authentication
                    login( username,  password);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 16.0),
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
