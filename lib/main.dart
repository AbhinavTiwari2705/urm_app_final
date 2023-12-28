import 'package:flutter/material.dart';
import 'package:urm_app/Screens/home_screen.dart';
import 'package:urm_app/Screens/signin_screen.dart';
import 'package:urm_app/Screens/manual.dart';
import 'package:urm_app/Screens/homeie.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // try {
  //   Response response = await post(
  //     Uri.parse('https://bspapp.sail-bhilaisteel.com/MES_MOB/APP/mesapp_login.jsp'),
  //     body: {
  //       'Username': username,
  //       'Password': password,
  //     },
  //   );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URM_Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
      routes: {
        '/homie': (context) => Homie(), // 
        '/home': (context) => const Home(),
        '/signin': (context) => const SignInScreen(),
        '/manual': (context) =>  Manual(),
      }
    );
  }
}

void main() {
  runApp(const MyApp());
}
