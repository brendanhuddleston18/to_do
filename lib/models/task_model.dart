class Task {
  final String id;
  String taskText;
  String description;
  final String timeCreated;
  String reminderDate;

  Task({
    required this.id,
    required this.taskText,
    required this.description,
    required this.timeCreated,
    required this.reminderDate,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'task': taskText,
      'description': description,
      'timeCreated': timeCreated,
      'reminderDate': reminderDate,
    };
  }
}
