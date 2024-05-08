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
          'CREATE TABLE newTasks(id INTEGER PRIMARY KEY, task TEXT, timeCreated TEXT)');
    },
    onUpgrade: (db, oldVersion, newVersion) {
      if (newVersion == 2) {
        db.execute(
            'CREATE TABLE newTasks(id INTEGER PRIMARY KEY, task TEXT, timeCreated TEXT)');
      }
    },
    version: 2,
  );

  Future<void> insertTask(Task task) async {
    final db = await database;

    await db.insert(
      'newTasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;

    await db.delete(
      'newTasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;

    final List<Map<String, Object?>> taskMaps = await db.query('newTasks');

    return taskMaps.map((taskMap) {
      return Task(
        id: taskMap['id'] as int,
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
  final Future<void> Function(int id) deleteTask;
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
