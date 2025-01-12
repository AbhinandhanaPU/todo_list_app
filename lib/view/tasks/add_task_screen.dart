import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/model/task_model.dart';
import 'package:todo_list_app/viewmodels/task_viewmodel.dart';

showAddTaskDialog(BuildContext context) {
  final TextEditingController taskController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: taskController,
          decoration: const InputDecoration(hintText: 'Enter task title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                final task = TaskModel(
                  id: DateTime.now().toString(),
                  title: taskController.text,
                  isCompleted: false,
                );
                Provider.of<TaskViewModel>(context, listen: false)
                    .addTask(task);
                taskController.clear();
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
          TextButton(
            onPressed: () {
              taskController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
