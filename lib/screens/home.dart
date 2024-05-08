import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import "dart:developer";
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task_model.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.insertTask,
    required this.tasksDB,
    required this.deleteTask,
  });

  final Future<void> Function(Task task) insertTask;
  final Future<void> Function(String id) deleteTask;
  final Future<List<Task>> Function() tasksDB;

  @override
  State<Home> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<Home> {
  int counter = 1;
  var uuid = Uuid();

  late Future<List<Task>> taskFuture;

  @override
  void initState() {
    super.initState();
    taskFuture = _getTasks();
  }

  Future<List<Task>> _getTasks() async {
    var fetchedTasks = await widget.tasksDB();
    return fetchedTasks;
  }

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
              builder: ((BuildContext context, AsyncSnapshot snapshot) {
                var tasks = snapshot.data ?? [];
                if (snapshot.hasData) {
                  return CupertinoListSection(
                    header: const Text("My reminders"),
                    children: tasks.map<Widget>((Task task) {
                      return CupertinoListTile(
                        title: Text(task.taskText),
                        subtitle: Text(task.timeCreated),
                        trailing: DeleteWidget(
                          onDeleteTask: widget.deleteTask,
                          taskID: task.id,
                          handleRefresh: () {
                            setState(
                              () {
                                taskFuture = _getTasks();
                              },
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return const Center(
                    child: Icon(CupertinoIcons.xmark),
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
                    String timeCreated = DateTime.now().toString();
                    Task taskToAdd = Task(
                        id: uuid.v4(),
                        taskText: newTask,
                        // isChecked: false,
                        timeCreated: timeCreated);
                    try {
                      widget.insertTask(taskToAdd);
                    } catch (e) {
                      print("didn't work: $e");
                    }
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
    required this.handleRefresh,
  });

  final Future<void> Function(String id) onDeleteTask;
  final Function() handleRefresh;
  final String taskID;

  @override
  State<DeleteWidget> createState() => _DeleteWidgetState();
}

class _DeleteWidgetState extends State<DeleteWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => widget
          .onDeleteTask(widget.taskID)
          .then((_) => widget.handleRefresh()),
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
