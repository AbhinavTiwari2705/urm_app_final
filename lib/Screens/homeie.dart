// Importing necessary Flutter packages
import 'package:flutter/material.dart';

// Creating a stateless widget named 'Homie'
class Homie extends StatelessWidget {
  // List of button data, each represented by a Map
  // Each Map contains the title, route and icon of the button
  // You can add more buttons as needed
  // The route is used to navigate to the specified screen
  // The icon is used to display the icon on the button
  // The title is used to display the title on the button
  // The title is also used to display the screen title

  final List<Map<String, dynamic>> buttonList = [
    {
      'title': 'Qr Scanner',
      'route': '/home',
      'icon': Icons.qr_code_scanner_sharp,
    },
    {
      'title': 'Bloom Report',
      'route': '/bloomReport',
      'icon': Icons.add_task_sharp,
    },
    {
      'title': 'ITM Display',
      'route': '/itmDisplay',
      'icon': Icons.mobile_friendly_sharp,
    },
    {'title': 'Manual', 'route': '/manual', 'icon': Icons.save_sharp},
    {'title': 'Test1', 'route': '/test1', 'icon': Icons.settings},
    {'title': 'Test2', 'route': '/test2', 'icon': Icons.settings},
    {'title': 'Logout', 'route': '/logout', 'icon': Icons.logout},
    // Add more buttons as needed
  ];

  // Build method to create the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with a title
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      // Body of the app containing a centered column of buttons
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Loop through the buttonList to create buttons dynamically
              for (var button in buttonList)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Function to handle button tap and navigate to the specified route
                      handleButtonTap(context, button['route']);
                    },
                    icon: Icon(
                      button['icon'],
                      color: Colors.white, // Set icon color to white
                    ),
                    label: Text(
                      button['title'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Button color
                      minimumSize: Size(double.infinity, 50), // Button size
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle button tap and navigate to the specified route
  void handleButtonTap(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
