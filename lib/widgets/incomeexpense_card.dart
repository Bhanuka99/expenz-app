import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class IncomeexpenseCard extends StatefulWidget {
  final String title;
  final double amount;
  final String imageUrl;
  final Color cardColor;
  const IncomeexpenseCard({
    super.key, 
    required this.title, 
    required this.amount, 
    required this.imageUrl, 
    required this.cardColor
  });

  @override
  State<IncomeexpenseCard> createState() => _IncomeexpenseCardState();
}

class _IncomeexpenseCardState extends State<IncomeexpenseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.45,
      height: MediaQuery.of(context).size.width*0.25,
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Container(
                width: MediaQuery.of(context).size.width*0.15,
                height: MediaQuery.of(context).size.height*0.10,
                decoration: BoxDecoration(
                  color: kmainWhiteColor,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Image.asset(
                  widget.imageUrl,
                  width: 70,
                  fit: BoxFit.cover,
                  ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: kmainWhiteColor
                  ),
                ),
                Text(
                  "\$${widget.amount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kmainWhiteColor
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}