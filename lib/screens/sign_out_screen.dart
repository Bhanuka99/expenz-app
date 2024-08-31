import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/responsive.dart';
import 'package:expenz/widgets/reusable/long_button_widget.dart';
import 'package:flutter/material.dart';

class SignOutScreen extends StatefulWidget {
  const SignOutScreen({super.key});

  @override
  State<SignOutScreen> createState() => _SignOutScreenState();
}

class _SignOutScreenState extends State<SignOutScreen> {
  
  //for checkbox
  bool _rememberMe = false;
  //form key for validations
  final _formKey = GlobalKey<FormState>();

  //contrallers for textform field
  final TextEditingController _userNameContraller = TextEditingController();
  final TextEditingController _userEmailContraller = TextEditingController();
  final TextEditingController _userPasswordContraller = TextEditingController();
  final TextEditingController _userConfirmPasswordContraller = TextEditingController();

  @override
  void dispose() {
    _userNameContraller.dispose();
    _userEmailContraller.dispose();
    _userPasswordContraller.dispose();
    _userConfirmPasswordContraller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child:Padding(
            padding: const EdgeInsets.all(kDefalutPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter your \nPersonal Details",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: kmainBlackColor
                ),
                ),
                const SizedBox(height: 30,),
                //form
                Form(
                  key: _formKey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //form fields
                    TextFormField(
                      controller: _userNameContraller,
                      //check the that input is valid input
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter Your Name!";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _userEmailContraller,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter Your Email!";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _userPasswordContraller,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter Your Password!";
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _userConfirmPasswordContraller,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter Your Password Again!";
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    //remember me
                    Row(
                      children: [
                        const Text("Remember me for the next time",
                          style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kmainGreyColor
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            activeColor: kmainPurpleColor,
                            value: _rememberMe, onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              }
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        if(_formKey.currentState!.validate()){
                          String userName = _userNameContraller.text;
                          String email = _userEmailContraller.text;
                          String password = _userPasswordContraller.text;
                          String confirmPassword = _userConfirmPasswordContraller.text;

                          //save user data
                          
                        }
                      },
                      child: const LongButtonWidget(
                        buttonName: "Next", 
                        buttonColor: kmainPurpleColor
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ) 
        ),
      ),
    );
  }
}