import 'package:expenz/screens/main_screen.dart';
import 'package:expenz/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {

  final bool showmainScreen;
  const Wrapper({
    super.key, 
    required this.showmainScreen
    });

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.showmainScreen ? const MainScreen() : const OnboardingScreen();
  }
}