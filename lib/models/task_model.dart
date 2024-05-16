class Task {
  final String id;
  final String taskText;
  final String description;
  final String timeCreated;

   Task({
    required this.id,
    required this.taskText,
    required this.description,
    required this.timeCreated,
  });

  Map<String, Object?> toMap(){
    return {
      'id': id,
      'task': taskText,
      'description': description,
      'timeCreated': timeCreated,
    };
  }
}

