import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/viewmodels/task_viewmodel.dart';
import 'package:task_management_app/viewmodels/preferences_viewmodel.dart';
import 'package:task_management_app/views/preferences_screen.dart';
import '../models/task_model.dart';
import 'task_add_screen.dart';
import 'task_edit_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final allTasks = ref.watch(taskProvider); // Fetch all tasks
    final sortOrder = ref.watch(preferencesProvider.select(
        (prefs) => prefs.sortOrder)); // Get the sort order from preferences

    // Sort tasks based on the sortOrder (either by 'date' or 'priority')
    final sortedTasks = _sortTasks(allTasks, sortOrder);

    // Separate tasks into pending and completed
    final pendingTasks =
        sortedTasks.where((task) => !task.isCompleted).toList();
    final completedTasks =
        sortedTasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task List',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PreferencesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildTab(
                  text: 'Pending',
                  isSelected: _selectedTabIndex == 0,
                  onTap: () => setState(() => _selectedTabIndex = 0),
                ),
                const SizedBox(width: 8),
                _buildTab(
                  text: 'Completed',
                  isSelected: _selectedTabIndex == 1,
                  onTap: () => setState(() => _selectedTabIndex = 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _selectedTabIndex == 0
                ? TaskListView(
                    tasks: pendingTasks,
                    onTaskTap: (task) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskPage(task: task),
                        ),
                      );
                    },
                    onTaskDelete: (task) {
                      ref.read(taskProvider.notifier).deleteTask(task.id ?? 0);
                    },
                    onTaskToggle: (task, isCompleted) {
                      ref.read(taskProvider.notifier).updateTask(
                            Task(
                              id: task.id,
                              title: task.title,
                              description: task.description,
                              isCompleted: isCompleted,
                              startDate: task.startDate,
                              endDate: task.endDate,
                              priority: task.priority,
                            ),
                          );
                    },
                  )
                : TaskListView(
                    tasks: completedTasks,
                    onTaskTap: (task) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskPage(task: task),
                        ),
                      );
                    },
                    onTaskDelete: (task) {
                      ref.read(taskProvider.notifier).deleteTask(task.id ?? 0);
                    },
                    onTaskToggle: (task, isCompleted) {
                      ref.read(taskProvider.notifier).updateTask(
                            Task(
                              id: task.id,
                              title: task.title,
                              description: task.description,
                              isCompleted: isCompleted,
                              startDate: task.startDate,
                              endDate: task.endDate,
                              priority: task.priority,
                            ),
                          );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskAddPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTab({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }

  // Function to sort tasks based on the sortOrder
  List<Task> _sortTasks(List<Task> tasks, String sortOrder) {
    List<Task> sortedTasks = List.from(tasks);
    if (sortOrder == 'date') {
      sortedTasks.sort(
          (a, b) => a.startDate.compareTo(b.startDate)); // Sort by start date
    } else if (sortOrder == 'priority') {
      sortedTasks
          .sort((a, b) => a.priority.compareTo(b.priority)); // Sort by priority
    }
    return sortedTasks;
  }
}

class TaskListView extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onTaskTap;
  final Function(Task) onTaskDelete;
  final Function(Task, bool) onTaskToggle;

  const TaskListView({
    super.key,
    required this.tasks,
    required this.onTaskTap,
    required this.onTaskDelete,
    required this.onTaskToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(
        child: Text(
          'No tasks available.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return Card(
          elevation: 8,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: task.isCompleted
                      ? Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1)
                      : Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: task.isCompleted
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Switch(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      value: task.isCompleted,
                      onChanged: (value) {
                        onTaskToggle(task, value);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  task.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).dividerColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 22,
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        onTaskTap(task);
                      },
                      tooltip: 'Edit Task',
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 22,
                      ),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () {
                        onTaskDelete(task);
                      },
                      tooltip: 'Delete Task',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
