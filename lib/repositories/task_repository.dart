import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/helpers/databasehelper.dart';
import '../models/task_model.dart';

class TaskRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  // Insert a new task into the database
  Future<void> insertTask(Task task) async {
    try {
      await databaseHelper.insertTask(task);
      debugPrint('Task inserted successfully');
    } catch (e) {
      debugPrint('Error inserting task: $e');
    }
  }

  // Fetch all tasks from the database
  Future<List<Task>> fetchAllTasks() async {
    try {
      return await databaseHelper.fetchAllTasks();
    } catch (e) {
      debugPrint('Error fetching tasks: $e');
      return [];
    }
  }

  // Fetch tasks based on their completion status (completed or pending)
  Future<List<Task>> fetchFilteredTasks({required int isCompleted}) async {
    try {
      return await databaseHelper.fetchFilteredTasks(isCompleted: isCompleted);
    } catch (e) {
      debugPrint('Error fetching filtered tasks: $e');
      return [];
    }
  }

  // Update a task in the database
  Future<void> updateTask(Task task) async {
    try {
      await databaseHelper.updateTask(task);
      debugPrint('Task updated successfully');
    } catch (e) {
      debugPrint('Error updating task: $e');
    }
  }

  // Delete a task from the database
  Future<void> deleteTask(int id) async {
    try {
      await databaseHelper.deleteTask(id);
      debugPrint('Task deleted successfully');
    } catch (e) {
      debugPrint('Error deleting task: $e');
    }
  }

  // Count the total number of tasks in the database
  Future<int> countTasks() async {
    try {
      return await databaseHelper.countTasks();
    } catch (e) {
      debugPrint('Error counting tasks: $e');
      return 0;
    }
  }
}

 final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository();
});
