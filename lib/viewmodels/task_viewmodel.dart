import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list_app/model/task_model.dart';
import 'package:todo_list_app/services/task_sevices.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskServices _taskServices;
  final StreamController<List<TaskModel>> _taskController =
      StreamController<List<TaskModel>>.broadcast();

  TaskViewModel(this._taskServices) {
    _fetchTasks();
  }

  Stream<List<TaskModel>> get taskStream => _taskController.stream;

  Future<void> _fetchTasks() async {
    try {
      final tasks = await _taskServices.fetchTasks();
      _taskController.add(tasks);
    } catch (e) {
      _taskController.addError('Failed to fetch tasks: $e');
    }
  }

  Future<void> addTask(TaskModel task) async {
    await _taskServices.addTask(task);
    await _fetchTasks();
  }

  Future<void> editTaskName(String taskId, String newTitle) async {
    await _taskServices.editTaskName(taskId, newTitle);
    await _fetchTasks();
  }

  Future<void> updateTaskStatus(String taskId, bool isCompleted) async {
    await _taskServices.updateTaskStatus(taskId, isCompleted);
    await _fetchTasks();
  }

  Future<void> deleteTask(String taskId) async {
    await _taskServices.deleteTask(taskId);
    await _fetchTasks();
  }
}
