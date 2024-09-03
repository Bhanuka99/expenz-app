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
  //Delete the expense from the shared pref from id
  Future <void> deleteIncome (int id, BuildContext context) async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingIncomes = pref.getStringList(_incomeKey);

      //convert the existing list to dart objects
      List<Income> existingIncomeObject = [];
      if(existingIncomes!=null){
        existingIncomeObject = 
            existingIncomes.map((e) => Income.fromJSON(json.decode(e)),).toList();
        
        //Remove the expense with specified id from the list
        existingIncomeObject.removeWhere((income) => income.id == id);

        // convert thr list of dart objects to list of strigs(json)
        List<String> updatedIncomes = 
            existingIncomeObject.map((e) => json.encode(e.toJSON()),).toList();
        
        //save the updated list of expenses to shared pref
        await pref.setStringList(_incomeKey, updatedIncomes);

        //show message
        if(context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Income Deleted successfully!"),
            duration: Duration(seconds: 2),
          )
        );
       }

      }
    } catch(err){
        if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on deleting Income!"),
            duration: Duration(seconds: 2),
          )
        );
       }
    }
    }
    //remove all incomes from shared pref
  Future<void> removeAllIncomes(BuildContext context) async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_incomeKey);

      //show snackbar
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Delete all incomes successfully!"),
            duration: Duration(seconds: 2),
          )
        );
       }

    }catch(err){
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on deleting Incomes!"),
            duration: Duration(seconds: 2),
          )
        );
       }
    }
  }
}