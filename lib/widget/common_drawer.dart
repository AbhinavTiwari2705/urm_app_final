import 'package:flutter/material.dart';


// This is a common drawer for all screens

class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('User'),
            accountEmail: Text('email'),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/homie');
            }
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),

          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('QR'),
            
          ),
          ListTile(
            leading: Icon(Icons.mediation),
            title: Text('Bloom Report'),
          ),
          ListTile(
            leading: Icon(Icons.mode_fan_off_rounded),
            title: Text('Test1'),
          ),
          ListTile(
            leading: Icon(Icons.newspaper),
            title: Text('Test2'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
