import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/responsive.dart';
import 'package:expenz/model/expense_model.dart';
import 'package:expenz/model/income_model.dart';
import 'package:expenz/widgets/category_card.dart';
import 'package:expenz/widgets/pie_chart_card.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenseCategory,double> expenseCategorytotal;
  final Map<IncomeCategory,double> incomeCategorytotal;
  final List<Expense> expenseList;
  final List<Income> incomeList;
  const BudgetScreen({
    super.key, 
    required this.expenseCategorytotal, 
    required this.incomeCategorytotal, 
    required this.expenseList, 
    required this.incomeList,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {

  double expenseTotal = 0;
  double incomeTotal = 0;

  int _selectedMethod = 0;

  //method to fine category color
  Color getCategoryColor(dynamic category){
    if(category is ExpenseCategory){
      return expenseCategoryColors[category]!;
    }else{
      return incomeCategoryColors[category]!;
    }
  }

    @override
  void initState() {
    setState(() {
      //total amount of expenses
      for( var i=0; i < widget.expenseList.length;i++){
        expenseTotal += widget.expenseList[i].amount;
      }
      //total amount of income
      for( var j=0; j < widget.incomeList.length;j++){
        incomeTotal += widget.incomeList[j].amount;
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final data = _selectedMethod == 0 ? 
      widget.expenseCategorytotal : widget.incomeCategorytotal;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Financial Report",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: kmainBlackColor
        ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
            children: [
              Padding(
                padding:const EdgeInsets.symmetric(
                  horizontal: kDefalutPadding,
                  vertical: kDefalutPadding/2
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.06,
                  decoration: BoxDecoration(
                    color: kmainWhiteColor,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: kmainBlackColor.withOpacity(0.1),
                        blurRadius: 20,
                      ),
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:_selectedMethod ==0 
                            ? kmainRedColor : kmainWhiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,horizontal: 57
                            ),
                            child: Text("Expense",style: TextStyle(
                              fontSize: 16,
                              color: _selectedMethod == 0 
                              ? kmainWhiteColor : kmainBlackColor,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:_selectedMethod ==1 
                            ? kmainGreenColor : kmainWhiteColor,

                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,horizontal: 57
                            ),
                            child: Text("Income",style: TextStyle(
                              fontSize: 16,
                              color: _selectedMethod == 1 
                              ? kmainWhiteColor : kmainBlackColor,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //pie chart
              const SizedBox(height: 20,),
              PieChartCard(
                expenseCategorytotal:widget.expenseCategorytotal,
                incomeCategorytotal:widget.incomeCategorytotal ,
                isExpense: _selectedMethod ==0,
                totalAmount: _selectedMethod == 0 ? expenseTotal : incomeTotal,
              ),
              const SizedBox(height: 20,),
              //list of categories
              SizedBox(
                height: MediaQuery.of(context).size.height*0.3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final category = data.keys.toList()[index];
                    final total = data.values.toList()[index];
                    return CategoryCard(
                      title: category.name,
                      amount: total,
                      totalAmount: data.values.reduce((a, b) => a + b),
                      progressColor: getCategoryColor(category),
                      isExpense: _selectedMethod == 0,
                    );
                  },
                ),
              )
            ],
          ) ,
        ),
      ),
    );
  }
}