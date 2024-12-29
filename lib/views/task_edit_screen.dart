import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../viewmodels/task_viewmodel.dart';

class EditTaskPage extends ConsumerStatefulWidget {
  final Task task;

  const EditTaskPage({super.key, required this.task});

  @override
  ConsumerState<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends ConsumerState<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late int _priority;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _priority = widget.task.priority;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final updatedTask = Task(
        id: widget.task.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        isCompleted: widget.task.isCompleted,
        startDate: widget.task.startDate,
        endDate: widget.task.endDate,
        priority: _priority,
      );

      ref.read(taskProvider.notifier).updateTask(updatedTask);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task updated successfully')),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildInputCard({required String title, required Widget child}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isWideScreen ? 32.0 : 16.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInputCard(
                  title: 'Task Title',
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter task title',
                      border: InputBorder.none,
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Title is required'
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  title: 'Task Description',
                  child: TextFormField(
                    controller: _descriptionController,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                    decoration: const InputDecoration(
                      hintText: 'Enter task description',
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  title: 'Priority',
                  child: DropdownButtonFormField<int>(
                    value: _priority,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value != null) setState(() => _priority = value);
                    },
                    items: [1, 2, 3]
                        .map((priority) => DropdownMenuItem(
                              value: priority,
                              child: Text(
                                'Priority: $priority',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  title: 'Start Date',
                  child: TextFormField(
                    initialValue:
                        '${widget.task.startDate.toLocal()}'.split(' ')[0],
                    readOnly: true,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                    decoration: const InputDecoration(
                      hintText: 'Start date',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  title: 'End Date',
                  child: TextFormField(
                    initialValue:
                        '${widget.task.endDate.toLocal()}'.split(' ')[0],
                    readOnly: true,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                    decoration: const InputDecoration(
                      hintText: 'End date',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
