import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/responsive.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/incomeexpense_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  //save user name
  String usrename = "";

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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeexpenseCard(
                            title: "Income", 
                            amount: 1200, 
                            imageUrl: "assets/images/income.png", 
                            cardColor: kmainGreenColor
                          ),
                          IncomeexpenseCard(
                            title: "Expences", 
                            amount: 1000, 
                            imageUrl: "assets/images/expense.png", 
                            cardColor: kmainRedColor
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      )
    );
  }
}