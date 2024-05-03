import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task_model.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.insertTask,
    required this.tasksDB,
  });

  final Future<void> Function(Task task) insertTask;
  final Future<List<Task>> Function() tasksDB;

  @override
  State<Home> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<Home> {
  int counter = 1;

  late Future<List<Task>> taskFuture;

  @override
  void initState() {
    super.initState();
    taskFuture = _getTasks();
  }

  Future<List<Task>> _getTasks() async {
    var fetchedTasks = await widget.tasksDB();
    return fetchedTasks;
    // return await widget.tasksDB();
  }

  // void handleChecked(bool? value, int index) {
  //   setState(() => tasks[index]["isChecked"] = value);
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color.fromRGBO(0, 127, 255, 1),
        leading: Text("Panel"),
        middle: Text("Brendan's To Do List"),
        trailing: Text("Time"),
      ),
      child: Stack(
        children: [
          FutureBuilder<List<Task>>(
              future: taskFuture,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  var tasks = snapshot.data ?? [];
                  return CupertinoListSection(
                    header: const Text("My reminders"),
                    children: tasks.map((task) {
                      return CupertinoListTile(
                          title: Text(task.task),
                          subtitle: Text(task.timeCreated));
                    }).toList(),
                  );
                }
              })),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: TextInputWidget(
                  onAddTask: (String newTask) {
                    dynamic timeCreated = DateTime.now();
                    var taskToAdd = Task(
                        id: counter,
                        task: newTask,
                        isChecked: false,
                        timeCreated: timeCreated.toString());
                    widget.insertTask(taskToAdd);
                    setState(() {
                      counter += 1;
                      taskFuture = _getTasks();
                    });
                  },
                ),
              ))
        ],
      ),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({super.key, required this.onAddTask});

  final Function(String) onAddTask;

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
        controller: controller,
        placeholder: "Enter a task!",
        suffix: IconButton(
          onPressed: () => widget.onAddTask(controller.text),
          icon: const Icon(CupertinoIcons.paperplane),
        ));
  }
}

class DeleteWidget extends StatefulWidget {
  const DeleteWidget({
    super.key,
    required this.onDeleteTask,
    required this.taskID,
  });

  final Function(int taskID) onDeleteTask;
  final int taskID;

  @override
  State<DeleteWidget> createState() => _DeleteWidgetState();
}

class _DeleteWidgetState extends State<DeleteWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => widget.onDeleteTask(widget.taskID),
      icon: const Icon(CupertinoIcons.delete),
    );
  }
}

class Checkmark extends StatefulWidget {
  const Checkmark({super.key});

  @override
  State<Checkmark> createState() => _CheckmarkState();
}

class _CheckmarkState extends State<Checkmark> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
