import 'package:flutter/cupertino.dart';
import 'package:to_do/screens/home.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'tasks_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE newestTasks(id TEXT, task TEXT, timeCreated TEXT)');
    },
    onUpgrade: (db, oldVersion, newVersion) {
      if (newVersion == 4) {
        db.execute(
            'CREATE TABLE newestTasks(id TEXT, task TEXT, timeCreated TEXT)');
      }
    },
    version: 4,
  );

  Future<void> insertTask(Task task) async {
    final db = await database;

    await db.insert(
      'newestTasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTask(String id) async {
    final db = await database;

    await db.delete(
      'newestTasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;

    final List<Map<String, Object?>> taskMaps = await db.query('newestTasks');

    return taskMaps.map((taskMap) {
      return Task(
        id: taskMap['id'] as String,
        taskText: taskMap['task'] as String,
        // isChecked: taskMap['isChecked'] == 1,
        timeCreated: taskMap['timeCreated'] as String,
      );
    }).toList();
  }

  runApp(MyApp(
    insertTask: insertTask,
    deleteTask: deleteTask,
    getTasks: getTasks,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.getTasks,
      required this.insertTask,
      required this.deleteTask});

  final Future<void> Function(Task task) insertTask;
  final Future<void> Function(String id) deleteTask;
  final Future<List<Task>> Function() getTasks;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Home(
        insertTask: insertTask,
        deleteTask: deleteTask,
        tasksDB: getTasks,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
