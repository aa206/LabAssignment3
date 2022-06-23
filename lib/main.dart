import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mytutor/views/loginscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MySplashScreen(title: 'Slumshop Admin'),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  
@override
void initState(){
  super.initState();
  Timer(
    const Duration(seconds: 3),
    () => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginScreen())));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
               image:AssetImage('assets/tutor.png'),
               fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 50, 0, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                  Text("        MYTutor",style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,)),
                  CircularProgressIndicator(),
                  Text("Version 0.1",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,))

                ]

              )
              ),
        ],
    ),
    );
  }
}
