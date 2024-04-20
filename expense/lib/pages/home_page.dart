import 'package:expense/components/expense_summary.dart';
import 'package:expense/components/expense_tile.dart';
import 'package:expense/data/expense_data.dart';
import 'package:expense/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  @override
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  final newExpenseDollarController = TextEditingController();
  final newExpenseCentController = TextEditingController();

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Provider.of<ExpenseData>(context, listen: false).prepareData();
  // }
  void addNewExpense() {

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
      title: Text('Add New Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: newExpenseNameController,
            decoration: InputDecoration(
              hintText: 'Expense Name',
            ),
          ),
          Row(children: [
            Expanded(
              child: TextField(
                controller: newExpenseDollarController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Dollar',
                )
            )),Expanded(
              child: 
              TextField(
                controller: newExpenseCentController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Cent'),))],)
          // TextField(
          //   controller: newExpenseAmountController,
          //   decoration: InputDecoration(
          //     hintText: 'Amount',
          //   ),
          // ),
        ]
      ),
     

      actions: [
        MaterialButton(
          onPressed: save,
          child: Text('Save'),
        ),
        MaterialButton(
          onPressed: cancel,
          child: Text('Cancel'),
        ),
      ],
    )
    );
  }
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }
  void save() {
    // Provider.of<ExpenseData>(context, listen: false).addExpense(ExpenseItem(
    //   name: newExpenseNameController.text,
    //   amount: double.parse(newExpenseAmountController.text),
    //   dateTime: DateTime.now().millisecondsSinceEpoch.toDouble(),
    // ));
    String amount = '${newExpenseDollarController.text + '.' + newExpenseCentController.text}';
    ExpenseItem expenseItem = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amount,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addExpense(expenseItem);
    Navigator.pop(context);
    clear();
  }
  void cancel() {
    Navigator.pop(context);
    clear();
  }
  void clear(){
    newExpenseNameController.clear();
    // newExpenseAmountController.clear();
    newExpenseDollarController.clear();
    newExpenseCentController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        
        child: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      body: ListView(children:[
        ExpenseSummary(startOfWeek: value.startOfWeek(DateTime.now())),
        const SizedBox(height: 20,),
        ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: Provider.of<ExpenseData>(context).getAllExpenseList().length,
        itemBuilder: (context, index) =>
        ExpenseTile(name: value.getAllExpenseList()[index].name, amount: value.getAllExpenseList()[index].amount, dateTime: value.getAllExpenseList()[index].dateTime, deleteTapped: (p0) => deleteExpense(value.getAllExpenseList()[index])
        ),
        )
      ]),
      // ListView.builder(
      //   itemCount: Provider.of<ExpenseData>(context).getAllExpenseList().length,
      //   itemBuilder: (context, index) =>
      //   ExpenseTile(name: value.getAllExpenseList()[index].name, amount: value.getAllExpenseList()[index].amount, dateTime: value.getAllExpenseList()[index].dateTime)
        // {
        //   return ListTile(
        //     title: Text(Provider.of<ExpenseData>(context).getAllExpenseList()[index].name),
        //     subtitle: Text(Provider.of<ExpenseData>(context).getAllExpenseList()[index].dateTime.toString()),
        //     trailing: Text('\$' + Provider.of<ExpenseData>(context).getAllExpenseList()[index].amount.toString()),
        //   );
        // },
      )
    );

  }
}