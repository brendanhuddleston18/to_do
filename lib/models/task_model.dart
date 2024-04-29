class Task {
  final int id;
  final String task;
  final bool isChecked;
  final String timeCreated;

   Task({
    required this.id,
    required this.task,
    required this.isChecked,
    required this.timeCreated,
  });

  Map<String, Object?> toMap(){
    return {
      'id': id,
      'task': task,
      'isChecked': isChecked,
      'timeCreated': timeCreated,
    };
  }
}

