import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/responsive.dart';
import 'package:expenz/model/expense_model.dart';
import 'package:expenz/model/income_model.dart';
import 'package:expenz/widgets/reusable/long_button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {

  //State to track the expence or income
  int _selectedMethode = 0;
  ExpenseCategory _expenseCategory = ExpenseCategory.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  final TextEditingController _titileController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    _titileController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethode == 0 ? kmainRedColor : kmainGreenColor,
      body: SafeArea(
        child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefalutPadding),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kmainWhiteColor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethode = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethode == 0 ? kmainRedColor : kmainWhiteColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 57,vertical: 10),
                              child: Text("Expense",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _selectedMethode == 0 ? kmainWhiteColor : kmainBlackColor,
                              ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethode = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethode == 1 ? kmainGreenColor : kmainWhiteColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 57,vertical: 10),
                              child: Text("Income",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _selectedMethode == 1 ? kmainWhiteColor : kmainBlackColor,
                  
                              ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefalutPadding),
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.12),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("How Much?",style: TextStyle(
                          color: kmainWhiteColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                         ),
                        ),
                        TextField(
                          style: TextStyle(
                            fontSize: 60,
                            color: kmainWhiteColor,
                            fontWeight: FontWeight.bold
                          ),
                          decoration: InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: kmainWhiteColor,
                              fontSize: 60,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //user data form
                Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                  decoration: const BoxDecoration(
                    color: kmainWhiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      child: Column(
                        children: [
                          //category dropdown
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefalutPadding,
                                horizontal: 20
                              ),
                            ),
                            items: _selectedMethode == 0 ? ExpenseCategory.values.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category.name)
                              );
                            },).toList():IncomeCategory.values.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category.name)
                              );
                            },).toList(),
                            value: _selectedMethode == 0 ? _expenseCategory : _incomeCategory, 
                            onChanged: (value) {
                              setState(() {
                                _selectedMethode == 0 ? 
                                  _expenseCategory = value as ExpenseCategory : 
                                  _incomeCategory = value as IncomeCategory ;
                              });
                            },
                            ),
                            const SizedBox(height: 15,),
                            //title
                            TextFormField(
                              controller: _titileController,
                              decoration: InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100), 
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefalutPadding,
                                horizontal: 20
                              ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            //description
                            TextFormField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                hintText: "Description",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100), 
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefalutPadding,
                                horizontal: 20
                              ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            //amount
                            TextFormField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Amount",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100), 
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefalutPadding,
                                horizontal: 20
                              ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            //date picker
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      initialDate: DateTime.now(),
                                      context: context, 
                                      firstDate: DateTime(2020), 
                                      lastDate: DateTime(2025),
                                    ).then((value) {
                                        if(value != null){
                                          setState(() {
                                            _selectedDate = value;
                                          });
                                        }
                                      }
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: kmainPurpleColor
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 20
                                        ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: kmainWhiteColor,
                                          ),
                                          SizedBox(width: 10,),
                                          Text("Select Date",style: TextStyle(
                                            color: kmainWhiteColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMd().format(_selectedDate),
                                  style: const TextStyle(
                                    color: kmainGreyColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            //time picker
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        if(value != null){
                                          setState(() {
                                            _selectedTime = DateTime(
                                              _selectedDate.year,
                                              _selectedDate.month,
                                              _selectedDate.day,
                                              value.hour,
                                              value.minute
                                            );
                                          });
                                        }
                                      }
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: kmainYellowColor
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 20
                                        ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.watch,
                                            color: kmainWhiteColor,
                                          ),
                                          SizedBox(width: 10,),
                                          Text("Select Time",style: TextStyle(
                                            color: kmainWhiteColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat.jm().format(_selectedTime),
                                  style: const TextStyle(
                                    color: kmainGreyColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            const Divider(
                              color: kmainGreyColor,
                              thickness: 3,
                            ),
                            const SizedBox(height: 20,),
                            LongButtonWidget(
                              buttonName: "Add", 
                              buttonColor: _selectedMethode == 0 ? kmainRedColor : kmainGreenColor
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) 
      )
    );
  }
}