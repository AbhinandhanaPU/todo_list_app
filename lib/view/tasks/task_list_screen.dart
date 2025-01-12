import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/app_colors.dart';
import 'package:todo_list_app/constants/app_style.dart';
import 'package:todo_list_app/model/task_model.dart';
import 'package:todo_list_app/services/auth_services.dart';
import 'package:todo_list_app/view/tasks/add_task_screen.dart';
import 'package:todo_list_app/view/tasks/edit_task.dart';
import 'package:todo_list_app/viewmodels/task_viewmodel.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.accent,
        title: const Text(
          'To Do List',
          style: AppStyles.heading,
        ),
        leading: IconButton(
          onPressed: () {
            Provider.of<AuthService>(context, listen: false).logout();
          },
          icon: const Icon(
            Icons.logout,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              showAddTaskDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            child: const Text(
              'Add Task',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: Provider.of<TaskViewModel>(context).taskStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final tasks = snapshot.data ?? [];
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                '''No tasks available\n Add a task using 'Add Task' button''',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: ListView.separated(
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  color: AppColors.cardBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        color: task.isCompleted
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 2,
                        decorationColor: AppColors.textSecondary,
                      ),
                    ),
                    leading: Checkbox(
                      value: task.isCompleted,
                      activeColor: AppColors.primary,
                      checkColor: AppColors.cardBackground,
                      onChanged: (bool? value) {
                        if (value != null) {
                          Provider.of<TaskViewModel>(context, listen: false)
                              .updateTaskStatus(task.id, value);
                        }
                      },
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: task.isCompleted
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                          onPressed: () {
                            showEditTaskDialog(context, task);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: task.isCompleted
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                          onPressed: () {
                            Provider.of<TaskViewModel>(context, listen: false)
                                .deleteTask(task.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
