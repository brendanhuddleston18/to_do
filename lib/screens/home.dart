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
  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
          backgroundColor: Color.fromARGB(255, 79, 152, 189),
          leading: Text("Panel"),
          middle: Text("Brendan's To Do List")),
      child: Stack(
        children: [
          CupertinoListSection(
              header: const Text('My Reminders'),
              children: <CupertinoListTile>[
                for (String task in tasks)
                  CupertinoListTile(
                    title: Text(task),
                    leading: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: CupertinoColors.activeGreen,
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
                    setState(() {
                      (tasks.add(newTask));
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
        prefix: IconButton(
          onPressed: () => widget.onAddTask(controller.text),
          icon: const Icon(CupertinoIcons.add),
        ));
  }
}
