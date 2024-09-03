import 'dart:convert';

import 'package:expenz/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {

  //Define the key for storing expenses in shared pref
  static const String _expenseKey = 'expense';
  
  //save the expense to shared pref
  Future<void> saveExpenses(Expense expence, BuildContext context) async {
    try{

      SharedPreferences pref = await SharedPreferences.getInstance();
      List <String>? existingExpenses = pref.getStringList(_expenseKey);

      //convert existing expenses to a list of expenses objects
      List <Expense> existingExpensObject = [];

      if(existingExpenses != null){
        existingExpensObject = 
        existingExpenses.map((e) => Expense.fromJSON(json.decode(e)),).toList();
      }
      //add the new expense to the list
       existingExpensObject.add(expence);

       //Convert the list of Expense objects back to a list of strings
       List <String> updatedExpenses = 
          existingExpensObject.map((e) =>json.encode(e.toJSON()),).toList();
       
       //Save the updated list of exxpenses to shared pref
       await pref.setStringList(_expenseKey, updatedExpenses);

       //show message
       if(context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Expense added successfully!"),
          duration: Duration(seconds: 2),
          )
        );
       }

    }catch(err){
      //show message
       if(context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error on adding Expense!"),
          duration: Duration(seconds: 2),
          )
        );
       }
    }
  }
  //load the expenses from shared pref
  Future <List<Expense>> loadExpense () async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    List<String>? existingExpenses = pref.getStringList(_expenseKey);

    //convert the existing expenses to list of expense objects
    List<Expense> loadedExpenses = [];
    if(existingExpenses!=null){
      loadedExpenses = 
      existingExpenses.map((e) => Expense.fromJSON(json.decode(e)),).toList();
    }
    return loadedExpenses;
  }

  //Delete the expense from the shared pref from id
  Future <void> deleteExpense (int id, BuildContext context) async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingExpenses = pref.getStringList(_expenseKey);

      //convert the existing list to dart objects
      List<Expense> existingExpensObject = [];
      if(existingExpenses!=null){
        existingExpensObject = 
            existingExpenses.map((e) => Expense.fromJSON(json.decode(e)),).toList();
        
        //Remove the expense with specified id from the list
        existingExpensObject.removeWhere((expense) => expense.id == id);

        // convert thr list of dart objects to list of strigs(json)
        List<String> updatedExpenses = 
            existingExpensObject.map((e) => json.encode(e.toJSON()),).toList();
        
        //save the updated list of expenses to shared pref
        await pref.setStringList(_expenseKey, updatedExpenses);

        //show message
        if(context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense Deleted successfully!"),
            duration: Duration(seconds: 2),
          )
        );
       }

      }
    } catch(err){
        if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on deleting Expense!"),
            duration: Duration(seconds: 2),
          )
        );
       }
    }
  }
  //remove all expenses from shared pref
  Future<void> removeAllExpenses (BuildContext context) async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_expenseKey);

      //show snackbar
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Delete all expenses successfully!"),
            duration: Duration(seconds: 2),
          )
        );
       }

    }catch(err){
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on deleting Expenses!"),
            duration: Duration(seconds: 2),
          )
        );
       }
    }
  }
}