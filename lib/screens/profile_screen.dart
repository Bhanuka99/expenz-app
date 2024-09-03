import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/responsive.dart';
import 'package:expenz/screens/onboarding_screen.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //save user name
  String username = "";
  String email = "";
   @override
  void initState() {
    //get user name
    UserService.getUserData().then((value) {
      if(value["userName"] != null && value["userEmail"] != null){
        setState(() {
          username = value["userName"]!;
          email = value["userEmail"]!;
        });
      }
    },
    );
    super.initState();
  }

  //open scaffold messenger for logout
  void _showBottomSheet(BuildContext context){
    showModalBottomSheet(
      backgroundColor: kmainWhiteColor,
      context: context, 
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(kDefalutPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Are you sure want to log out?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kmainBlackColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(kmainRedColor),
                    ),
                    onPressed: () async {
                      //clear all user data
                      await UserService.clearUserData();
                      //clear all user expenses 
                      if(context.mounted) {
                        await ExpenseService().removeAllExpenses(context);
                      }
                      //Clear all user incomes
                      if(context.mounted) {
                        await IncomeService().removeAllIncomes(context);
                      }
                      //navigate to onboardScreen
                      if(context.mounted){
                        Navigator.pushAndRemoveUntil(
                        context, 
                        MaterialPageRoute(builder: (context) =>const OnboardingScreen(),), 
                        (route) => false,
                      );
                      }
                    }, 
                    child:const Text(
                      "Yes",
                      style: TextStyle(
                        color: kmainWhiteColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(kmainGreenColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    child:const Text(
                      "No",
                      style: TextStyle(
                        color: kmainWhiteColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: 
            Padding(
              padding: const EdgeInsets.all(kDefalutPadding),
              child: Column(
                children: [
                  Row(
                    children:[
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,style:const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            email,style:const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kmainGreyColor
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                                  
                        }, 
                        icon: const Icon(
                          Icons.edit,size: 30,color: kmainPurpleColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const ProfileCard(
                    icon: Icons.wallet, 
                    title: "My wallet", 
                    color: kmainPurpleColor
                  ),
                  const ProfileCard(
                    icon: Icons.settings, 
                    title: "Settings", 
                    color: kmainYellowColor
                  ),
                  const ProfileCard(
                    icon: Icons.download, 
                    title: "Export Data", 
                    color: kmainGreenColor
                  ),
                  GestureDetector(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: const ProfileCard(
                      icon: Icons.logout, 
                      title: "Log Out", 
                      color: kmainRedColor
                    ),
                  ),
                ],
              ),
            ),
        )
      ),
    );
  }
}