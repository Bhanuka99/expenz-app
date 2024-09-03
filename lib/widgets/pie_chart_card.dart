import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/responsive.dart';
import 'package:expenz/model/expense_model.dart';
import 'package:expenz/model/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartCard extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategorytotal;
  final Map<IncomeCategory, double> incomeCategorytotal;
  final bool isExpense;
  final double totalAmount;
  const PieChartCard({
    super.key, 
    required this.expenseCategorytotal, 
    required this.incomeCategorytotal, 
    required this.isExpense, 
    required this.totalAmount
  });

  @override
  State<PieChartCard> createState() => _PieChartCardState();
}

class _PieChartCardState extends State<PieChartCard> {

  ///pie chart section data
  List<PieChartSectionData> getChartSections(){
    if(widget.isExpense){
      return [
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.food],
          value: widget.expenseCategorytotal[ExpenseCategory.food] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.health],
          value: widget.expenseCategorytotal[ExpenseCategory.health] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.shopping],
          value: widget.expenseCategorytotal[ExpenseCategory.shopping] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.subscription],
          value: widget.expenseCategorytotal[ExpenseCategory.subscription] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.transport],
          value: widget.expenseCategorytotal[ExpenseCategory.transport] ?? 0,
          showTitle: false,
          radius: 40,
        ),
      ];
    }else{
      return [
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.freelance],
          value: widget.incomeCategorytotal[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.passive],
          value: widget.incomeCategorytotal[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.salary],
          value: widget.incomeCategorytotal[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.sales],
          value: widget.incomeCategorytotal[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 40,
        ),
      ];
    }
  }
  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -90,
      sections: getChartSections(),
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 250,
      padding: const EdgeInsets.all(kDefalutPadding),
      decoration: BoxDecoration(
        color: kmainWhiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("\$${widget.totalAmount.toStringAsFixed(0)}",style: const TextStyle(
                fontSize: 30,
                color: kmainBlackColor,
                fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}