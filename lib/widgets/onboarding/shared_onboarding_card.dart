import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class SharedOnboardingCard extends StatelessWidget {

  final String titile;
  final String imageUrl;
  final String discription;
  const SharedOnboardingCard({
    super.key, 
    required this.titile, 
    required this.imageUrl, 
    required this.discription
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageUrl,
          width: 300,
          fit: BoxFit.cover,
          ),
          const SizedBox(height: 20,),
          Text(titile,
            textAlign: TextAlign.center,
            style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: kmainBlackColor,
          ),
          ),
          const SizedBox(height: 20,),
          Text(discription,
            textAlign: TextAlign.center,
            style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: kmainGreyColor,
          ),
          ),
        ],
      ),
    );
  }
}