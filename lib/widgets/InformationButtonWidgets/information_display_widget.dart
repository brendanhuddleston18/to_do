import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

// ---------------------------------------------------- //

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

// ---------------------------------------------------- //

class InfoTextBox extends StatefulWidget {
  const InfoTextBox(
      {super.key, required this.taskInfo, required this.reminderDate});

  final String taskInfo;
  final String reminderDate;

  @override
  State<InfoTextBox> createState() => _InfoTextBoxState();
}

class _InfoTextBoxState extends State<InfoTextBox> {
  String timeToShow = "";
  @override
  Widget build(BuildContext context) {
    setState(() {
      timeToShow = widget.reminderDate;
    });
    // return Text(widget.taskInfo);
    return Column(
      children: [Text(widget.taskInfo), Text(timeToShow)],
    );
  }
}

// ---------------------------------------------------- //

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

// ---------------------------------------------------- //

class InfoAlertDialog extends StatefulWidget {
  const InfoAlertDialog({
    super.key,
    required this.taskData,
    required this.updateTask,
  });

  final Map taskData;
  final Future<void> Function(Map task) updateTask;

  @override
  State<InfoAlertDialog> createState() => _InfoAlertDialogState();
}

class _InfoAlertDialogState extends State<InfoAlertDialog> {
  bool isEditing = false;
  late String taskInfo;
  late String reminderDate;

  @override
  void initState() {
    super.initState();
    taskInfo = widget.taskData["description"];
    reminderDate = widget.taskData["reminder_date"];
  }

  void handleUpdateTaskInfo(String updatedInfo) {
    setState(() {
      taskInfo = updatedInfo;
      isEditing = false;
    });

    widget.taskData["description"] = taskInfo;
    widget.updateTask(widget.taskData);
  }

  void handleReminder(DateTime timeToShow) {
    setState(
      () {
        reminderDate = DateFormat('dd-MMM-yyyy - kk:mm').format(timeToShow);
      },
    );
    widget.taskData["reminder_date"] = reminderDate;
    widget.updateTask(widget.taskData);
    AwesomeNotifications().createNotification(
        actionButtons: [
          NotificationActionButton(key: 'viewTask', label: 'View Task'),
          NotificationActionButton(key: 'delete', label: 'Delete task')
        ],
        content: NotificationContent(
            payload: {"taskID": widget.taskData["task_id"]},
            id: widget.taskData["task_id"].hashCode,
            channelKey: "basic_channel",
            title: widget.taskData["task_text"],
            body: widget.taskData["description"]),
        schedule: NotificationCalendar.fromDate(date: timeToShow));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.taskData["task_text"]),
          ReminderButton(
            handleReminder: handleReminder,
          )
        ],
      ),
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
            child: InfoTextBox(
              taskInfo: taskInfo,
              reminderDate: reminderDate,
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: InfoTextInput(
            updateTaskInfo: handleUpdateTaskInfo,
            isEditing: isEditing,
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------- //

class ExitButton extends StatefulWidget {
  const ExitButton({
    super.key,
    required this.onCloseModal,
  });

  final Function() onCloseModal;

  @override
  State<ExitButton> createState() => _ExitButtonState();
}

class _ExitButtonState extends State<ExitButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.xmark_circle_fill),
      onPressed: () {
        widget.onCloseModal();
        Navigator.pop(context);
      },
    );
  }
}
// --------------------------------- //

class ReminderButton extends StatefulWidget {
  const ReminderButton({super.key, required this.handleReminder});

  final Function(DateTime timeToShow) handleReminder;

  @override
  State<ReminderButton> createState() => _ReminderButtonState();
}

class _ReminderButtonState extends State<ReminderButton> {
  DateTime reminderDate = DateTime.now();

  void _showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: ((BuildContext context) {
          return Container(
            height: 250,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (DateTime newReminderDate) {
                      setState(() {
                        reminderDate = newReminderDate;
                      });
                    },
                    initialDateTime: reminderDate,
                    mode: CupertinoDatePickerMode.dateAndTime,
                    use24hFormat: true,
                    showDayOfWeek: true,
                  ),
                ),
                CupertinoButton(
                  child: const Text("Done"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.handleReminder(reminderDate);
                  },
                )
              ],
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(CupertinoIcons.bell_circle),
        onPressed: () {
          _showDatePicker();
        });
  }
}
