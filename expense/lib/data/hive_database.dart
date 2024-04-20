import 'package:hive/hive.dart';
import '../models/expense_item.dart';

class HiveDatabase {
  final _myBox = Hive.box('expense_data');

  void savedData(List<ExpenseItem> allExpense){
    List<List<dynamic>> allExpenseFormatted = [];  
    for (var expense in allExpense){
      List<dynamic> expenseFormatted = [expense.name, expense.amount, expense.dateTime];
      allExpenseFormatted.add(expenseFormatted);
    }
    _myBox.put('all_expense', allExpenseFormatted);
  }

  List<ExpenseItem> readData(){
    List savedExpenses = _myBox.get('all_expense') ?? [];
    List<ExpenseItem> allExpense = [];
    for(int i = 0; i < savedExpenses.length; i++){
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];
      ExpenseItem expenseItem = ExpenseItem(name: name, amount: amount, dateTime: dateTime);
      allExpense.add(expenseItem);
    }
    return allExpense;
  }

}