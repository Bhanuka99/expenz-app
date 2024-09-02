import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/responsive.dart';
import 'package:expenz/model/expense_model.dart';
import 'package:expenz/model/income_model.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomeList;
  final void Function(Expense) onDismissExpense;
  final void Function(Income) onDismissIncome;
  const TransactionScreen({
    super.key, 
    required this.expensesList, 
    required this.onDismissExpense, 
    required this.incomeList, 
    required this.onDismissIncome
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kDefalutPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("See your financial report",style: TextStyle(
                  color: kmainPurpleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                ),
                const SizedBox(height: 20,),
                const Text("Expenses",style: TextStyle(
                  color: kmainBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.35,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.expensesList.isEmpty ? 
                          const Text("No expenses added yet...Add some expenses to see here!!",
                              style: TextStyle(
                                fontSize: 16,
                                color: kmainGreyColor
                          ),
                        ):
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.expensesList.length,
                          itemBuilder: (context, index) {
                            final expense = widget.expensesList[index];
                            return Dismissible(
                              key: ValueKey(expense),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                setState(() {
                                  widget.onDismissExpense(expense);
                                });
                              },
                              child: ExpenseCard(
                                title: expense.title, 
                                description: expense.description, 
                                category: expense.category, 
                                amount: expense.amount,
                                time: expense.time
                              ),
                            );
                          },
                          )
                      ],
                    ),
                  ),
                ),
                const Text("Incomes",style: TextStyle(
                  color: kmainBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.35,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.incomeList.isEmpty ? 
                          const Text("No income added yet...Add some incomes to see here!!",
                              style: TextStyle(
                                fontSize: 16,
                                color: kmainGreyColor
                          ),
                        ):
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.incomeList.length,
                          itemBuilder: (context, index) {
                            final income = widget.incomeList[index];
                            return Dismissible(
                              key: ValueKey(income),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                setState(() {
                                  widget.onDismissIncome(income);
                                });
                              },
                              child: IncomeCard(
                                title: income.title, 
                                description: income.description, 
                                category: income.category, 
                                amount: income.amount,
                                time: income.time
                              ),
                            );
                          },
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}