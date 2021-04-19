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
