import 'package:flutter/material.dart';
import 'package:flutter_uas/animasi/bottom_dart.dart';
import 'package:flutter_uas/screen/first_page.dart';
import 'package:flutter_uas/screen/home.dart';
import 'package:flutter_uas/screen/login.dart';
import 'package:flutter_uas/screen/registrasi.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const FirstPage(),
        "/login": (context) => const Login(),
        "/register": (context) => const Register(),
        "/home": (context) => const Home(),
        AnimatedBottomBar.tag: (context) => AnimatedBottomBar(),
        
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
