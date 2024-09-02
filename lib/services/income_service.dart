import 'dart:convert';

import 'package:expenz/model/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {

  //Define the key to storing incomes in shared pref
  static const String _incomeKey = 'income';

  //save the income to share pref

  Future <void> saveincome (Income income, BuildContext context) async {
    try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    
    List<String>? existingIncomes = pref.getStringList(_incomeKey);

    //Convert the existing incomes to a list of income objects
    List<Income> existingIncomeObject = [];

    if(existingIncomes!=null){
      existingIncomeObject = 
        existingIncomes.map((e) => Income.fromJSON(json.decode(e)),).toList();
    }

    //Add the new income to the List
    existingIncomeObject.add(income);

    //convert the list of objects to list of strings
    List<String> updatedIncomes = 
        existingIncomeObject.map((e) => json.encode(e.toJSON()),).toList();
    //Save the updated ;ist in shared pref
    await pref.setStringList(_incomeKey, updatedIncomes);

    if(context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Income Added succesfully!"),
        duration: Duration(seconds: 2),
        )
    );
    }
    }catch(err){
    if(context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Error in adding Income!"),
        duration: Duration(seconds: 2),
        )
      );
    }
    } 
  }
  //load the income from the shared pref
  Future <List<Income>> loadIncome () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List <String>? existingIncomes = pref.getStringList(_incomeKey);

    //convert the existingIncomelist to objects
    List<Income> loadedIncomes = [];
    if(existingIncomes!=null){
      loadedIncomes = 
          existingIncomes.map((e) => Income.fromJSON(json.decode(e)),).toList();
    }
    return loadedIncomes;
  }
}