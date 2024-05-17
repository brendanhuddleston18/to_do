import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/task_model.dart';

class InfoDisplayButtonWidget extends StatefulWidget {
  const InfoDisplayButtonWidget({
    super.key,
    required this.information,
    required this.showModal,
  });

  final String information;
  final Function(String) showModal;

  @override
  State<InfoDisplayButtonWidget> createState() =>
      _InformationDisplayButtonState();
}

class _InformationDisplayButtonState extends State<InfoDisplayButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.info_circle),
      onPressed: () {
        widget.showModal(widget.information);
      },
    );
  }
}

class InfoEditButton extends StatefulWidget {
  const InfoEditButton({super.key, required this.isEditing});

  final Function() isEditing;

  @override
  State<InfoEditButton> createState() => _InfoEditButtonState();
}

class _InfoEditButtonState extends State<InfoEditButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.pencil_circle),
      onPressed: () {
        widget.isEditing();
      },
    );
  }
}

// class InfoStopEditButton extends StatefulWidget {
//   const InfoStopEditButton({super.key});

//   @override
//   State<InfoStopEditButton> createState() => _InfoStopEditButtonState();
// }

// class _InfoStopEditButtonState extends State<InfoStopEditButton> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class InfoTextBox extends StatefulWidget {
  const InfoTextBox({
    super.key,
    required this.taskInfo,
  });

  final String taskInfo;

  @override
  State<InfoTextBox> createState() => _InfoTextBoxState();
}

class _InfoTextBoxState extends State<InfoTextBox> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.taskInfo);
  }
}

class InfoTextInput extends StatefulWidget {
  const InfoTextInput({
    super.key,
    required this.updateTaskInfo,
    required this.isEditing,
  });

  final Function(String) updateTaskInfo;
  final bool isEditing;

  @override
  State<InfoTextInput> createState() => _InfoTextInputState();
}

class _InfoTextInputState extends State<InfoTextInput> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool editing = widget.isEditing;
    if (editing == true) {
      return CupertinoTextField(
          controller: controller,
          suffix: IconButton(
            icon: const Icon(CupertinoIcons.plus),
            onPressed: () {
              widget.updateTaskInfo(controller.text);
            },
          ));
    } else {
      return const Text("");
    }
  }
}

class InfoAlertDialog extends StatefulWidget {
  const InfoAlertDialog({
    super.key,
    required this.taskData,
    required this.updateTask,
  });

  final Task taskData;
  final Future<void> Function(Task task) updateTask;

  @override
  State<InfoAlertDialog> createState() => _InfoAlertDialogState();
}

class _InfoAlertDialogState extends State<InfoAlertDialog> {
  bool isEditing = false;
  String taskInfo = "";

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.taskData.taskText),
      content: Column(children: [
        Padding(
            padding: const EdgeInsets.only(left: 140),
            child: InfoEditButton(
              isEditing: () {
                setState(() => isEditing = true);
              },
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: InfoTextBox(taskInfo: widget.taskData.description)),
        Align(
          alignment: Alignment.bottomCenter,
          child: InfoTextInput(
            updateTaskInfo: (String updatedInfo) {
              setState(() => taskInfo = updatedInfo);
              Task updatedTask = Task(
                  description: taskInfo,
                  id: widget.taskData.id,
                  taskText: widget.taskData.taskText,
                  timeCreated: widget.taskData.timeCreated);
              widget.updateTask(updatedTask);
            },
            isEditing: isEditing,
          ),
        )
      ]),
    );
  }
}
