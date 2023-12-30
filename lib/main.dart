import 'package:flutter/material.dart';
import 'package:urm_app/Screens/home_screen.dart';
import 'package:urm_app/Screens/signin_screen.dart';
import 'package:urm_app/Screens/manual.dart';
import 'package:urm_app/Screens/homeie.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URM_Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
      routes: {
        '/homie': (context) => Homie(), // Calling the home screen located at lib/Screens/homeie.dart
        '/home': (context) => const Home(), // Calling the home screen located at lib/Screens/home_screen.dart
        '/signin': (context) => const SignInScreen(),// Calling the signin screen located at lib/Screens/signin_screen.dart
        '/manual': (context) =>  Manual(),// Calling the manual screen located at lib/Screens/manual.dart
        // 'ITM': (context) => const ITM(), // Calling the home screen located at lib/Screens/home_screen.dart (FOR FUTURE USE)
        // 'Bloom Report': (context) => const BloomReport(), // Calling the home screen located at lib/Screens/home_screen.dart (FOR FUTURE USE)
        //'signup': (context) => const SignupScreen(), // Calling the signup screen located at lib/Screens/signup_screen.dart (FOR FUTURE USE)
      }
    );
  }
}

void main() {
  runApp(const MyApp());
}
