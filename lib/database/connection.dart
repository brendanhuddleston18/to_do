// import 'package:flutter/cupertino.dart';
// import 'package:to_do/screens/home.dart';
// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter/widgets.dart';
// import 'package:to_do/models/task_model.dart';
// // TODO: Create Function for this:
// // Store in global variable
// // Look into late variables
//   final database = openDatabase(
//     join(await getDatabasesPath(), 'tasks_database.db'),
//     onCreate: (db, version) {
//       return db.execute(
//           'CREATE TABLE newTasks(id INTEGER PRIMARY KEY, task TEXT, timeCreated TEXT)');
//     },
//     version: 1,
//   );
  
//   Future<void> insertTask(Task task) async {
//     final db = await database;

//     await db.insert(
//       'newTasks',
//       task.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//     Future<List<Task>> tasks() async {
//     final db = await database;

//     final List<Map<String, Object?>> taskMaps = await db.query('newTasks');

//     return taskMaps.map((taskMap) {
//       return Task(
//         id: taskMap['id'] as int,
//         taskText: taskMap['task'] as String,
//         // isChecked: taskMap['isChecked'] == 1,
//         timeCreated: taskMap['timeCreated'] as String,
//       );
//     }).toList();
//   }