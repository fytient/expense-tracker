import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense/data/expense_data.dart';
import 'package:expense/bar graph/bar_graph.dart';
import 'package:expense/dateTime/date_time.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});
  double calculateMax(
    ExpenseData value, String sunday, String monday, String tuesday, String wednesday, String thursday, String friday, String saturday) {
      double? max = 100;
      List<double> values = [
        value.calculateDailyExpenseSummary()[sunday] ?? 0,
        value.calculateDailyExpenseSummary()[monday] ?? 0,
        value.calculateDailyExpenseSummary()[tuesday] ?? 0,
        value.calculateDailyExpenseSummary()[wednesday] ?? 0,
        value.calculateDailyExpenseSummary()[thursday] ?? 0,
        value.calculateDailyExpenseSummary()[friday] ?? 0,
        value.calculateDailyExpenseSummary()[saturday] ?? 0,
      ]; 
      values.sort();
      max = values.last * 1.1;
      return max == 0 ? 100 : max;

    }
    String calculateWeekTotal(
      ExpenseData value,
      String sunday, 
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
        List<double> values = [
        value.calculateDailyExpenseSummary()[sunday] ?? 0,
        value.calculateDailyExpenseSummary()[monday] ?? 0,
        value.calculateDailyExpenseSummary()[tuesday] ?? 0,
        value.calculateDailyExpenseSummary()[wednesday] ?? 0,
        value.calculateDailyExpenseSummary()[thursday] ?? 0,
        value.calculateDailyExpenseSummary()[friday] ?? 0,
        value.calculateDailyExpenseSummary()[saturday] ?? 0,
        ];
        double total = 0;
        for (int i = 0; i < values.length; i++){
          total += values[i];
        }
        return total.toStringAsFixed(2);
      }
    
  @override
  Widget build(BuildContext context) {
    String sunday = convertDateToString(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateToString(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateToString(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateToString(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder:(context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [Text('Weekly Total: ', style: TextStyle(fontWeight: FontWeight.bold),),
            Text('\$' + calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday))],),
          ),
          SizedBox(
            height: 200, 
            child: MyBarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday), 
              SundayAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0, 
              MondayAmount:  value.calculateDailyExpenseSummary()[monday] ?? 0, 
              TuesdayAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0, 
              WednesdayAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0, 
              ThursdayAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0, 
              FridayAmount: value.calculateDailyExpenseSummary()[friday] ?? 0, 
              SaturdayAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
          ),
          ),
        ],
      ),
    );
  }

}