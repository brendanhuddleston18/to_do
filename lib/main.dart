import 'package:flutter/cupertino.dart';
import 'package:to_do/screens/home.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';




void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'tasks_database.db'),
    onCreate:(db, version) {
      return db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY, task TEXT, timeCreated TEXT)'
      );
    },
    version: 1,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      );
  }
}