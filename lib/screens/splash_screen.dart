import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/splashscreenimg.png'),
                    fit: BoxFit.cover))),
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 100),
            child: Column(children: const [
              Text(
                "YOUR SAFETY IS OUR NO.1",
                style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(60, 59, 110, 1),
                    fontWeight: FontWeight.bold),
              ),
              LinearProgressIndicator(),
              Text("\nCUCKOO",
                  style: TextStyle(
                      fontSize: 45,
                      fontFamily: 'Open Sans Bold',
                      color: Color.fromRGBO(178, 35, 52, 1),
                      fontWeight: FontWeight.bold)),
              Text("WATER FILTER",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Open Sans Bold',
                      color: Color.fromRGBO(60, 59, 110, 1),
                      fontWeight: FontWeight.bold)),
              Text(
                "\n\n\n\n\nVersion 0.1",
                style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(60, 59, 110, 1),
                    fontWeight: FontWeight.bold),
              ),
            ]))
      ],
    );
  }
}
