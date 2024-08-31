import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class LongButtonWidget extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  const LongButtonWidget({
    super.key, 
    required this.buttonName, 
    required this.buttonColor
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: buttonColor,
      ),
      child: Center(
        child: Text(buttonName,style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: kmainWhiteColor
        ),
        ),
      ),
    );
  }
}