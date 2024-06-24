// --------External------------------//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

// --------My Widgets---------------//
import 'package:to_do/widgets/checkbox_widget.dart';
import 'package:to_do/widgets/delete_widget.dart';
import 'package:to_do/widgets/InformationButtonWidgets/information_display_widget.dart';
import 'package:to_do/widgets/text_input_widget.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/widgets/pull_down_widget.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key,
      required this.insertTask,
      required this.tasksDB,
      required this.deleteTask,
      required this.updateTask,
      required this.handleDarkMode,
      required this.currentTheme,
      required this.isLoggedIn,
      required this.username});

  final Future<void> Function(Task task) insertTask;
  final Future<void> Function(String id) deleteTask;
  final Future<void> Function(Task task) updateTask;

  final void Function(bool isOn) handleDarkMode;
  final bool isLoggedIn;
  final Future<List<Task>> Function() tasksDB;
  final CupertinoThemeData currentTheme;

  final String username;

  @override
  State<Home> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<Home> {
  var uuid = const Uuid();

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
      navigationBar: CupertinoNavigationBar(
        backgroundColor: widget.currentTheme.primaryContrastingColor,
        middle: Text("${widget.username}'s To Do List"),
        trailing: PullDownMenu(
          builder: (_, showMenu) {
            return CupertinoButton(
              onPressed: showMenu,
              padding: EdgeInsets.zero,
              pressedOpacity: 1,
              child: const Icon(CupertinoIcons.ellipsis),
            );
          },
          isLoggedIn: widget.isLoggedIn,
        ),
      ),
      child: Stack(
        children: [
          FutureBuilder<List<Task>>(
              future: taskFuture,
              builder: ((BuildContext context, AsyncSnapshot snapshot) {
                var tasks = snapshot.data ?? [];
                if (snapshot.hasData) {
                  return CupertinoListSection(
                    backgroundColor:
                        widget.currentTheme.primaryContrastingColor,
                    header: const Text(
                      "My Reminders:",
                      selectionColor: Colors.blue,
                    ),
                    children: tasks.map<Widget>((Task task) {
                      return Animate(
                          effects: const [],
                          child: CupertinoListTile(
                            key: ValueKey(task.id),
                            leading: const CheckboxWidget(),
                            title: Text(task.taskText),
                            subtitle: Text(task.timeCreated),
                            additionalInfo: InfoDisplayButtonWidget(
                                information: task.taskText,
                                showModal: (String info) {
                                  showCupertinoModalPopup(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Stack(
                                          children: [
                                            InfoAlertDialog(
                                              taskData: task,
                                              updateTask: widget.updateTask,
                                            ),
                                            Positioned(
                                                right: 60,
                                                top: 332,
                                                child: ExitButton(
                                                  onCloseModal: () {
                                                    setState(() {
                                                      taskFuture = _getTasks();
                                                    });
                                                  },
                                                ))
                                          ],
                                        );
                                      });
                                }),
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
                          ));
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
                    DateTime timeCreated = DateTime.now();
                    String formattedTimeCreated =
                        DateFormat('dd-MMM-yyyy - kk:mm').format(timeCreated);
                    Task taskToAdd = Task(
                        id: uuid.v4(),
                        taskText: newTask,
                        description: '',
                        timeCreated: formattedTimeCreated,
                        reminderDate: '');
                    try {
                      widget.insertTask(taskToAdd);
                    } catch (e) {
                      print("didn't work: $e");
                    }
                    setState(() {
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
