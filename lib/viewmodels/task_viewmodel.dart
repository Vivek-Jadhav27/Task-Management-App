import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../repositories/task_repository.dart'; 

// StateNotifier to manage tasks
class TaskViewModel extends StateNotifier<List<Task>> {
  TaskViewModel(this._taskRepository) : super([]);

  final TaskRepository _taskRepository;

  // Fetch tasks from repository (this could be from SQLite or Hive)
  Future<void> loadTasks() async {
    final tasks = await _taskRepository.fetchAllTasks();
    state = tasks;
  }

  // Add a new task
  void addTask(Task task) {
    state = [...state, task];
    _taskRepository.insertTask(task); 
  }

  // Update a task
  void updateTask(Task updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task
    ];
    _taskRepository.updateTask(updatedTask); 
  }

  // Delete a task
  void deleteTask(int id) {
    state = state.where((task) => task.id != id).toList();
    _taskRepository.deleteTask(id);
  }
}

// Riverpod provider for the ViewModel
final taskProvider = StateNotifierProvider<TaskViewModel, List<Task>>((ref) {
  final taskRepository = ref.read(taskRepositoryProvider); 
  final taskViewModel = TaskViewModel(taskRepository);
  Future.microtask(() => taskViewModel.loadTasks());
  return taskViewModel;
});
