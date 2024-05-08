class Task {
  final int id;
  final String taskText;
  // final bool isChecked;
  final String timeCreated;

   Task({
    required this.id,
    required this.taskText,
    // required this.isChecked,
    required this.timeCreated,
  });

  Map<String, Object?> toMap(){
    return {
      'id': id,
      'task': taskText,
      // 'isChecked': isChecked,
      'timeCreated': timeCreated,
    };
  }
}

