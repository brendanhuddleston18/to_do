class Task {
  final String id;
  final String taskText;
  final String description;
  final String timeCreated;
  final String reminderDate;

   Task({
    required this.id,
    required this.taskText,
    required this.description,
    required this.timeCreated,
    required this.reminderDate,
  });

  Map<String, Object?> toMap(){
    return {
      'id': id,
      'task': taskText,
      'description': description,
      'timeCreated': timeCreated,
      'reminderDate': reminderDate,
    };
  }
}

