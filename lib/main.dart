import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.checkUserName(),
      builder: (context, snapshot) {

        //if the snapshot is still waiting
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else{
          //snapshot.data will be true is there is a data in snapshot
          bool hasUserName = snapshot.data ?? false;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Inter",
            ),
            home: Wrapper(showmainScreen: hasUserName),
          );
        }
      },
    );
  }
}