import 'package:expense/data/expense_data.dart';
import 'package:expense/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';


void main() {
  // await Hive.initFlutter();
  // await Hive.openBox('expense_data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) =>
      const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
    );
  }
}
