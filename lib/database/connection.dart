// import 'package:flutter/cupertino.dart';
// import 'package:to_do/screens/home.dart';
// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter/widgets.dart';
// import 'package:to_do/models/task_model.dart';

// // TODO: Create Function for this: ✅
// // Store in global variable
// // Look into late variables
 
// void runDatabase() async {
//     final database = openDatabase(
//     join(await getDatabasesPath(), 'tasks_database.db'),
//     onCreate: (db, version) {
//       return db.execute(
//           'CREATE TABLE newestTasks(id TEXT, task TEXT, timeCreated TEXT)');
//     },
//     onUpgrade: (db, oldVersion, newVersion) {
//       if (newVersion == 4) {
//         db.execute(
//             'CREATE TABLE newestTasks(id TEXT, task TEXT, timeCreated TEXT)');
//       }
//     },
//     version: 4,
//   );

//   Future<void> insertTask(Task task) async {
//     final db = await database;

//     await db.insert(
//       'newestTasks',
//       task.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<void> deleteTask(String id) async {
//     final db = await database;

//     await db.delete(
//       'newestTasks',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<List<Task>> getTasks() async {
//     final db = await database;

//     final List<Map<String, Object?>> taskMaps = await db.query('newestTasks');

//     return taskMaps.map((taskMap) {
//       return Task(
//         id: taskMap['id'] as String,
//         taskText: taskMap['task'] as String,
//         // isChecked: taskMap['isChecked'] == 1,
//         timeCreated: taskMap['timeCreated'] as String,
//       );
//     }).toList();
//   }
// }