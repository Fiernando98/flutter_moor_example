import 'package:flutter/material.dart';
import 'package:flutter_moor_example/data/moor_database.dart';
import 'package:flutter_moor_example/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [Provider(create: (_) => AppDatabase())], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moor',
        theme: ThemeData(brightness: Brightness.light),
        home: HomePage());
  }
}

void snackMessage(String message, BuildContext context) {
  final SnackBar snackBar = SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.green,
      content: Text(message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void snackErrorMessage(String message, BuildContext context) {
  final SnackBar snackBar = SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red[700],
      content: Text(message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
