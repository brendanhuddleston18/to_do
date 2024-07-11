import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({
    super.key,
    required this.onAddTask,
  });

  final Function(String) onAddTask;

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  TextEditingController controller = TextEditingController();

  handleTaskAndClear() {
    widget.onAddTask(controller.text);
    controller.clear();
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
