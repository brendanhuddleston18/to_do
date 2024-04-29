import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<Home> {
  List<Map> tasks = [];

  int counter = 1;

  void handleChecked(bool? value, int index) {
    setState(() => tasks[index]["isChecked"] = value);
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
          CupertinoListSection(
              header: const Text('My Reminders'),
              children: <CupertinoListTile>[
                for (int i = 0; i < tasks.length; i++)
                  CupertinoListTile(
                    title: Text(tasks[i]["task"]),
                    subtitle: Text(tasks[i]["timeCreated"]),
                    leading: CupertinoCheckbox(
                      value: tasks[i]["isChecked"],
                      onChanged: (newValue) => handleChecked(newValue, i),
                    ),
                    trailing: DeleteWidget(
                      taskID: tasks[i]["id"],
                      onDeleteTask: (int id) {
                        setState(
                          () {
                            tasks.removeWhere((task) => task["id"] == id);
                          },
                        );
                      },
                    ),
                  ),
              ]),
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
                    Map<String, dynamic> map = {};
                    map["id"] = counter;
                    map["task"] = newTask;
                    map["isChecked"] = false;
                    map["timeCreated"] = timeCreated.toString();
                    setState(
                      () {
                        (tasks.add(map));
                        counter += 1;
                      },
                    );
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
