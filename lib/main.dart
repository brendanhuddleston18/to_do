import 'package:flutter/cupertino.dart';
import 'package:to_do/screens/home.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/screens/settings.dart';
import 'package:to_do/themes/dark_theme.dart';
import 'package:to_do/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'tasks_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tasksV6(id TEXT, task TEXT, description TEXT, timeCreated TEXT)');
    },
    onUpgrade: (db, oldVersion, newVersion) {
      if (newVersion == 6) {
        db.execute(
            'CREATE TABLE tasksV6(id TEXT, task TEXT, description TEXT, timeCreated TEXT)');
      }
    },
    version: 6,
  );

  Future<void> insertTask(Task task) async {
    final db = await database;

    await db.insert(
      'tasksV6',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTask(String id) async {
    final db = await database;

    await db.delete(
      'tasksV6',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateTask(Task task) async {
    final db = await database;

    await db
        .update('tasksV6', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<List<Task>> getTasks() async {
    final db = await database;

    final List<Map<String, Object?>> taskMaps = await db.query('tasksV6');

    return taskMaps.map((taskMap) {
      return Task(
        id: taskMap['id'] as String,
        taskText: taskMap['task'] as String,
        description: taskMap['description'] as String,
        timeCreated: taskMap['timeCreated'] as String,
      );
    }).toList();
  }

  runApp(MyApp(
    insertTask: insertTask,
    deleteTask: deleteTask,
    updateTask: updateTask,
    getTasks: getTasks,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp(
      {super.key,
      required this.getTasks,
      required this.insertTask,
      required this.deleteTask,
      required this.updateTask});

  final Future<void> Function(Task task) insertTask;
  final Future<void> Function(String id) deleteTask;
  final Future<void> Function(Task task) updateTask;
  final Future<List<Task>> Function() getTasks;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  CupertinoThemeData currentTheme = lightTheme;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void handleDarkMode(bool isOn) {
    if (isOn) {
      setState(() {
        currentTheme = darkTheme;
      });
    } else {
      setState(() {
        currentTheme = lightTheme;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      initialRoute: '/',
      routes: {
        '/settings': (context) => SettingsWidget(
              handleDarkMode: handleDarkMode,
            ),
      },
      home: Home(
        insertTask: widget.insertTask,
        deleteTask: widget.deleteTask,
        updateTask: widget.updateTask,
        handleDarkMode: handleDarkMode,
        tasksDB: widget.getTasks,
      ),
      debugShowCheckedModeBanner: false,
      theme: currentTheme,
    );
  }
}
