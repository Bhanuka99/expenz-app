import 'package:expenz/constants/colors.dart';
import 'package:expenz/model/expense_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_screen.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentPageIndex = 0;
  List<Expense>  expenseList = [];

  //Function to fetch expenses
  void fetchaAllExpenses () async {
    List<Expense> loadedExpenses =  await ExpenseService().loadExpense();
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  //Function to add new expense
  void addNewExpense(Expense newExpense){
    ExpenseService().saveExpenses(newExpense, context);

    //update the list of expense
    setState(() {
      expenseList.add(newExpense);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchaAllExpenses();
    });
  }
  
  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      HomeScreen(),
      TransactionScreen(),
      AddNewScreen(
        addExpense: addNewExpense,
      ),
      BudgetScreen(),
      ProfileScreen()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kmainWhiteColor,
        selectedItemColor: kmainPurpleColor,
        unselectedItemColor: kmainGreyColor,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500
        ),
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transaction"
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: const BoxDecoration(
                color: kmainPurpleColor,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.add , color: kmainWhiteColor, size: 30,
              ),
              ),
              label : "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: "Budget"
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
          ),
          ]
        ),
        body: pages[_currentPageIndex],
    );
  }
}