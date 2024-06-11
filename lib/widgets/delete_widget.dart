
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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