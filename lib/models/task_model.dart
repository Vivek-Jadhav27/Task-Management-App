class Task {
  final int? id; 
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime startDate; 
  final DateTime endDate;   
  final int priority;       

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.startDate,
    required this.endDate,
    this.priority = 3, // Default: Low priority
  });

  // Convert Task to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      priority: map['priority'],
    );
  }
}
