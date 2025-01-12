import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/model/task_model.dart';
import 'package:todo_list_app/viewmodels/task_viewmodel.dart';

showEditTaskDialog(BuildContext context, TaskModel task) {
  final TextEditingController taskController =
      TextEditingController(text: task.title);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(
          controller: taskController,
          decoration: const InputDecoration(hintText: 'Enter new task title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                Provider.of<TaskViewModel>(context, listen: false)
                    .editTaskName(task.id, taskController.text);
                taskController.clear();
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
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
