import 'package:flutter/cupertino.dart';
import 'package:to_do/screens/home.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do/models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'tasks_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, task TEXT, timeCreated TEXT)');
    },
    version: 1,
  );

  Future<void> insertTask(Task task) async {
    final db = await database;

    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  runApp(const MyApp());
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
