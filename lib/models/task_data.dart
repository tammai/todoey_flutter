import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoey_flutter/models/task.dart';

class TaskData extends ChangeNotifier {
  TaskData() {
    _initTasks();
  }

  List<Task> _tasks = [];
  late SharedPreferences _prefs;

  void _initTasks() async {
    _prefs = await SharedPreferences.getInstance();

    var prefsTasks = _prefs.getStringList('tasks') ?? [];

    if (prefsTasks.length > 0) {
      _tasks = prefsTasks.map((e) => Task.fromJson(jsonDecode(e))).toList();
      notifyListeners();
    }
  }

  void _syncTasks() {
    _prefs.setStringList('tasks', _tasks.map((e) => e.toJson()).toList());
    notifyListeners();
  }

  void resetTasks() {
    _tasks = [];
    _prefs.setStringList('tasks', []);
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    _syncTasks();
  }

  void toggleTask(Task task) {
    task.toggleDoneState();
    _syncTasks();
  }

  UnmodifiableListView<Task> get availableTasks => UnmodifiableListView(
        _tasks.where((element) => !element.isDone).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
      );

  UnmodifiableListView<Task> get doneTasks => UnmodifiableListView(
        _tasks.where((element) => element.isDone).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
      );
}
