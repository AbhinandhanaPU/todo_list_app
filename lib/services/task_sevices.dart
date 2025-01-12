import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list_app/model/task_model.dart';

class TaskServices {
  final String baseUrl =
      'https://todo-list-app-d5e0a-default-rtdb.asia-southeast1.firebasedatabase.app';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add a new task for an authenticated user
  Future<void> addTask(TaskModel task) async {
    final user = _auth.currentUser;
    final authToken = await user?.getIdToken();
    final String? userId = user?.uid;
    if (user == null) {
      log('No user is signed in');
      return;
    }
    final url = Uri.parse('$baseUrl/tasks/$userId.json?auth=$authToken');

    try {
      final response = await http.post(
        url,
        body: jsonEncode(task.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        log('Task added successfully');
      } else {
        log('Failed to add task: ${response.statusCode}, ${response.body}');
      }
    } catch (error) {
      log('Error adding task: $error');
    }
  }

  // fetch tasks
  Future<List<TaskModel>> fetchTasks() async {
    final user = _auth.currentUser;
    final authToken = await user?.getIdToken();
    final String? userId = user?.uid;

    if (user == null) {
      log('No user is signed in');
      return [];
    }

    final url = Uri.parse('$baseUrl/tasks/$userId.json?auth=$authToken');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>?;
      final tasks = data?.entries
              .map((e) => TaskModel.fromJson({...e.value, 'id': e.key}))
              .toList() ??
          [];
      return tasks;
    } else {
      throw Exception('Failed to fetch tasks: ${response.statusCode}');
    }
  }

  // Edit task name
  Future<void> editTaskName(String taskId, String newTitle) async {
    final user = _auth.currentUser;
    final authToken = await user?.getIdToken();
    final String? userId = user?.uid;
    if (user == null) {
      log('No user is signed in');
      return;
    }
    final url =
        Uri.parse('$baseUrl/tasks/$userId/$taskId.json?auth=$authToken');

    try {
      final response = await http.patch(
        url,
        body: jsonEncode({'title': newTitle}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        log('Task updated successfully');
      } else {
        log('Failed to update task: ${response.statusCode}, ${response.body}');
      }
    } catch (error) {
      log('Error updating task: $error');
    }
  }

  // Update task status
  Future<void> updateTaskStatus(String taskId, bool isCompleted) async {
    final user = _auth.currentUser;
    final authToken = await user?.getIdToken();
    final String? userId = user?.uid;
    if (user == null) {
      log('No user is signed in');
      return;
    }
    final url =
        Uri.parse('$baseUrl/tasks/$userId/$taskId.json?auth=$authToken');

    try {
      final response = await http.patch(
        url,
        body: jsonEncode({'isCompleted': isCompleted}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        log('Task status updated successfully');
      } else {
        log('Failed to update task status: ${response.statusCode}, ${response.body}');
      }
    } catch (error) {
      log('Error updating task status: $error');
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    final user = _auth.currentUser;
    final authToken = await user?.getIdToken();
    final String? userId = user?.uid;
    if (user == null) {
      log('No user is signed in');
      return;
    }
    final url =
        Uri.parse('$baseUrl/tasks/$userId/$taskId.json?auth=$authToken');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        log('Task deleted successfully');
      } else {
        log('Failed to delete task: ${response.statusCode}, ${response.body}');
      }
    } catch (error) {
      log('Error deleting task: $error');
    }
  }
}
