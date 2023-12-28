import 'package:flutter/material.dart';

class Homie extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var button in buttonList)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
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
                      primary: Colors.blue,
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void handleButtonTap(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
