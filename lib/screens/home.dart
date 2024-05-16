// --------External------------------//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:to_do/models/task_model.dart';

// --------My Widgets---------------//
import 'package:to_do/widgets/checkbox_widget.dart';
import 'package:to_do/widgets/delete_widget.dart';
import 'package:to_do/widgets/information_display_widget.dart';
import 'package:to_do/widgets/text_input_widget.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.insertTask,
    required this.tasksDB,
    required this.deleteTask,
    required this.updateTask,
  });

  final Future<void> Function(Task task) insertTask;
  final Future<void> Function(String id) deleteTask;
  final Future<void> Function(Task task) updateTask;
  final Future<List<Task>> Function() tasksDB;

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
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color.fromRGBO(229, 229, 234, 1),
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
                    header: const Text(
                      "My Reminders:",
                      selectionColor: Colors.blue,
                    ),
                    backgroundColor: const Color.fromRGBO(229, 229, 234, 1),
                    children: tasks.map<Widget>((Task task) {
                      return Animate(
                          effects: const [FlipEffect()],
                          child: CupertinoListTile(
                            key: ValueKey(task.id),
                            backgroundColor:
                                const Color.fromRGBO(239, 239, 244, 1),
                            leading: const CheckboxWidget(),
                            title: Text(task.taskText),
                            subtitle: Text(task.timeCreated),
                            additionalInfo: InfoDisplayButtonWidget(
                                information: task.taskText,
                                showModal: (String info) {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return InfoAlertDialog(
                                          taskData: task,
                                          updateTask: widget.updateTask,
                                          handleRefresh: () {
                                            setState(
                                              (){
                                                taskFuture = _getTasks();
                                              }
                                            );
                                          },
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
                    String timeCreated = DateTime.now().toString();
                    Task taskToAdd = Task(
                        id: uuid.v4(),
                        taskText: newTask,
                        description: '',
                        timeCreated: timeCreated);
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
