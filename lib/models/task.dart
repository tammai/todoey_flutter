import 'dart:convert';

class Task {
  Task({
    required this.id,
    required this.name,
    required this.createdAt,
    this.isDone = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      isDone: json['isDone'],
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  String id;
  String name;
  bool isDone;
  DateTime createdAt;

  void toggleDoneState() {
    isDone = !isDone;
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'isDone': isDone,
      'createdAt': createdAt.toIso8601String(),
    });
  }
}
