import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  //method to store the user name and uer email in shared pref
  static Future <void> storeUserdetails(
    {
    required String userName,
    required String userEmail,
    required String userPassword, 
    required String userConfirmPassword,
    required BuildContext context
    }) async{
      try{
        //check both passwords are same
        if(userPassword!=userConfirmPassword){
          //show a message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Passwords did not match!")),
          );
          return;
        }
        //store user name and email

        //create an instance from shared pref
        SharedPreferences pref = await SharedPreferences.getInstance();
        //store as key value pairs
        await pref.setString("userName", userName);
        await pref.setString("userEmail", userEmail);

        //show message
        if(context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User Data Saved succesfully"))
        );
        }

      }catch(err){
        err.toString();
      }
    }

    //method to checkwhether the username is saved in shared pref
    static Future<bool> checkUserName() async {
      //create an instance
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? userName = pref.getString("userName");
      return userName != null;
    }
}