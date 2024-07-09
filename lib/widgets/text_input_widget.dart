import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  const TextInputWidget(
      {super.key, required this.onAddTask, required this.testingTaskCreation});

  final Function(String) onAddTask;
  final Function() testingTaskCreation;

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  TextEditingController controller = TextEditingController();

  handleTaskAndClear() {
    widget.onAddTask(controller.text);
    controller.clear();
    widget.testingTaskCreation();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
        controller: controller,
        placeholder: "Enter a task!",
        suffix: IconButton(
          onPressed: () => handleTaskAndClear(),
          icon: const Icon(CupertinoIcons.paperplane),
        ));
  }
}
