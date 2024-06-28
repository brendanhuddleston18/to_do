import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do/globals.dart';
import 'package:to_do/notifications/notification_controller.dart';
import 'package:to_do/screens/home.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/screens/settings.dart';
import 'package:to_do/screens/login.dart';
import 'package:to_do/screens/profile.dart';
import 'package:to_do/themes/dark_theme.dart';
import 'package:to_do/themes/light_theme.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  String url = dotenv.env['url']!;
  String anonKey = dotenv.env['anonKey']!;

  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );

  final supabase = Supabase.instance.client;

  final User? user = supabase.auth.currentUser;

  final database = openDatabase(
    join(await getDatabasesPath(), 'tasks_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tasksV7(id TEXT, task TEXT, description TEXT, timeCreated TEXT, reminderDate TEXT)');
    },
    onUpgrade: (db, oldVersion, newVersion) {
      if (newVersion == 7) {
        db.execute(
            'CREATE TABLE tasksV7(id TEXT, task TEXT, description TEXT, timeCreated TEXT, reminderDate TEXT)');
      }
    },
    version: 7,
  );

  Future<void> insertTask(Task task) async {
    await supabase.from('user_tasks').insert({
      'user_id': user?.id,
      'task_text': task.taskText,
      'description': task.description,
      'time_created': task.timeCreated,
      'reminder_date': task.reminderDate,
      'task_id': task.id,
    });
    // final db = await database;

    // await db.insert(
    //   'tasksV7',
    //   task.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }

  Future<void> deleteTask(String id) async {
    await supabase.from('user_tasks').delete().eq('task_id', id);
    // final db = await database;

    // await db.delete(
    //   'tasksV7',
    //   where: 'id = ?',
    //   whereArgs: [id],
    // );
  }

  Future<void> updateTask(Task task) async {
    await supabase.from('user_tasks').update({
      'task_text': task.taskText,
      'description': task.description,
      'time_created': task.timeCreated,
      'reminder_date': task.reminderDate
    }).eq('task_id', task.id);
    // final db = await database;

    // await db
    //     .update('tasksV7', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<List<Task>> getTasks() async {
    final db = await database;

    final List<Map<String, Object?>> taskMaps = await db.query('tasksV7');

    return taskMaps.map((taskMap) {
      return Task(
        id: taskMap['id'] as String,
        taskText: taskMap['task'] as String,
        description: taskMap['description'] as String,
        timeCreated: taskMap['timeCreated'] as String,
        reminderDate: taskMap['reminderDate'] as String,
      );
    }).toList();
  }

  globalDeleteTask = deleteTask;
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basic notification channel")
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "basic_channel_group", channelGroupName: "Basic Group")
  ]);

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(MyApp(
    insertTask: insertTask,
    deleteTask: deleteTask,
    updateTask: updateTask,
    getTasks: getTasks,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.getTasks,
    required this.insertTask,
    required this.deleteTask,
    required this.updateTask,
  });

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
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreateMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod);
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

  bool handleDarkSwitch() {
    if (currentTheme == darkTheme) {
      return true;
    } else {
      return false;
    }
  }

  bool userLoggedIn = false;

  void handleLoggedIn(bool isSignedIn) {
    userLoggedIn = isSignedIn;
    if (!isSignedIn) {
      setState(() {
        username = "User";
      });
    }
  }

  String username = "User";
  String photoUrl =
      "https://www.vecteezy.com/vector-art/27708418-default-avatar-profile-icon-vector-in-flat-style";

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      initialRoute: '/login',
      routes: {
        '/settings': (context) => SettingsWidget(
              currentTheme: currentTheme,
              handleDarkMode: handleDarkMode,
              handleDarkSwitch: handleDarkSwitch,
            ),
        '/login': (context) => LoginWidget(
              handleLoggedIn: handleLoggedIn,
              handleUserInfo: (String newUsername, String newPhotoUrl) {
                setState(
                  () {
                    username = newUsername;
                    photoUrl = newPhotoUrl;
                  },
                );
              },
            ),
        '/profile': (context) => ProfileWidget(
              photoUrl: photoUrl,
              userLoggedIn: userLoggedIn,
              username: username,
              handleUserInfo: (String newUsername) {
                setState(() {
                  username = newUsername;
                });
              },
            )
      },
      home: Home(
        isLoggedIn: userLoggedIn,
        currentTheme: currentTheme,
        insertTask: widget.insertTask,
        deleteTask: widget.deleteTask,
        updateTask: widget.updateTask,
        handleDarkMode: handleDarkMode,
        tasksDB: widget.getTasks,
        username: username,
        handleLoggedIn: handleLoggedIn,
        photoUrl: photoUrl,
      ),
      debugShowCheckedModeBanner: false,
      theme: currentTheme,
    );
  }
}
