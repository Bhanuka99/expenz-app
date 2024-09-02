import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/responsive.dart';
import 'package:expenz/model/income_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeCard extends StatelessWidget {
  final String title;
  final String description;
  final IncomeCategory category;
  final double amount;
  final DateTime time;
  const IncomeCard({
    super.key, 
    required this.title, 
    required this.description, 
    required this.category, 
    required this.amount, 
    required this.time
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(kDefalutPadding),
      decoration: BoxDecoration(
        color: kmainWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kmainGreyColor.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1)
          ),
        ]
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: incomeCategoryColors[category]!.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                incomeCtegoryImages[category]!,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
                ),
            ),
          ),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kmainBlackColor
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  description,style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kmainGreyColor
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "+\$${amount.toStringAsFixed(2)}",style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kmainGreenColor
                ),
              ),
              Text(
                DateFormat.jm().format(time),style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kmainGreyColor
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}