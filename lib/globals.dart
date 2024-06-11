typedef DeleteTaskFunction = Future<void> Function(String taskId);

DeleteTaskFunction? globalDeleteTask;

