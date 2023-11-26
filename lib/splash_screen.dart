import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Screens/Home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Center(
          child: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 90,
            backgroundImage: AssetImage('assets/rick-and-morty-logo.png'),
          ))),
        backgroundColor: Colors.deepPurpleAccent,
        nextScreen: Home(),
        splashIconSize: 200,
        splashTransition: SplashTransition.rotationTransition,
    );
  }
}


