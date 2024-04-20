import 'package:expense/data/hive_database.dart';
import 'package:expense/dateTime/date_time.dart';
import 'package:expense/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier{
  List<ExpenseItem> overallExpnseList = [];
  List<ExpenseItem> getAllExpenseList() {
    return overallExpnseList;
  }
  // final db = HiveDatabase();
  // void prepareData(){
  //   if (db.readData().isNotEmpty){
  //     overallExpnseList = db.readData();
  //   }
  // }
  void addExpense(ExpenseItem expenseItem) {
    overallExpnseList.add(expenseItem);
    notifyListeners();
    // db.savedData(overallExpnseList);
  }
  void deleteExpense(ExpenseItem expenseItem) {
    overallExpnseList.remove(expenseItem);
    notifyListeners();
    // db.savedData(overallExpnseList);
  }
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
  DateTime startOfWeek(DateTime dateTime) {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sunday') {
        startOfWeek = today.subtract(Duration(days: i));
        
      }
    }
    return startOfWeek!;
  }
  Map<String, double> calculateDailyExpenseSummary(){
    Map<String, double> dailyExpenseSummary = {};
      for (var expense in overallExpnseList){
        String date = convertDateToString(expense.dateTime as DateTime);
        double amount = double.parse(expense.amount);
        if (dailyExpenseSummary.containsKey(date)){
          double currentAmount = dailyExpenseSummary[date]!;
          currentAmount += amount;
          dailyExpenseSummary[date] = currentAmount;
        } else {
          // dailyExpenseSummary[date] = expense.amount;
          dailyExpenseSummary.addAll({date: amount});
        }
  }
    return dailyExpenseSummary;
  }
  
}