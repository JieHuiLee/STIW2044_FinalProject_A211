import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromRGBO(217, 217, 217, 1), //D9D9D9
      theme: ThemeData(
        backgroundColor: const Color.fromRGBO(217, 217, 217, 1), //D9D9D9
        brightness: Brightness.light,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline5: TextStyle(fontSize: 20.0),
          bodyText1: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Hind',
              color: Color.fromRGBO(217, 217, 217, 1)),
        ),
      ),
      title: 'CUCKOO',
      home: const Scaffold(body: SplashScreen()),
    );
  }
}
