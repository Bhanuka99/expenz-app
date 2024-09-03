import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/responsive.dart';
import 'package:expenz/model/expense_model.dart';
import 'package:expenz/model/income_model.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/incomeexpense_card.dart';
import 'package:expenz/widgets/line_chart_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  final List<Expense> expenseList;
  final List<Income> incomeList;
  const HomeScreen({super.key, required this.expenseList, required this.incomeList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  //save user name
  String usrename = "";
  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  void initState() {
    //get user name
    UserService.getUserData().then((value) {
      if(value["userName"] != null){
        setState(() {
          usrename = value["userName"]!;
        });
      }
    },
    );
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.35,
                decoration: BoxDecoration(
                  color: ksubPurpleColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: kmainPurpleColor,
                              border: Border.all(
                                color: kmainPurpleColor,
                                width: 3
                              )
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Text(
                            usrename,style:const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                            
                            }, 
                            icon: const Icon(
                              Icons.notifications,size: 30,color: kmainPurpleColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 70,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeexpenseCard(
                            title: "Income", 
                            amount: incomeTotal, 
                            imageUrl: "assets/images/income.png", 
                            cardColor: kmainGreenColor
                          ),
                          IncomeexpenseCard(
                            title: "Expences", 
                            amount: expenseTotal, 
                            imageUrl: "assets/images/expense.png", 
                            cardColor: kmainRedColor
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //line chart
              const Padding(
                padding: EdgeInsets.all(kDefalutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Spend Frequency",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                    SizedBox(height: 20,),
                    LineChartCard(),
                  ],
                ),
              ),
              //recent transaction
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefalutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Recent Transactions",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                    const SizedBox(height: 20,),
                    Column(
                      children: [
                        widget.expenseList.isEmpty ? 
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
                          itemCount: widget.expenseList.length,
                          itemBuilder: (context, index) {
                            final expense = widget.expenseList[index];
                            return Dismissible(
                              key: ValueKey(expense),
                              direction: DismissDirection.startToEnd,
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
                    )
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}