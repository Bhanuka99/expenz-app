import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class FrontScreenCard extends StatelessWidget {
  const FrontScreenCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/logo.png",
        width: 100,
        fit: BoxFit.cover,
        ),
        const SizedBox(height: 20,),
        const Text("Expenz",style: TextStyle(
          color: kmainPurpleColor,
          fontSize: 40,
          fontWeight: FontWeight.bold
        ),)
      ],
    );
  }
}