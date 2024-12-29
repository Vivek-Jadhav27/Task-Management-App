import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../viewmodels/task_viewmodel.dart';

class TaskAddPage extends ConsumerStatefulWidget {
  const TaskAddPage({super.key});

  @override
  ConsumerState<TaskAddPage> createState() => _TaskAddPageState();
}

class _TaskAddPageState extends ConsumerState<TaskAddPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // Date pickers
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  int _priority = 3; // Default priority

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  // Method to save the task
  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        startDate: _startDate,
        endDate: _endDate,
        priority: _priority,
        isCompleted: false,
      );

      ref.read(taskProvider.notifier).addTask(newTask);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task added successfully')),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _pickStartDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        _startDate = pickedDate;
        _startDateController.text = '${_startDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  Future<void> _pickEndDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _endDate) {
      setState(() {
        _endDate = pickedDate;
        _endDateController.text = '${_endDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title input
                _buildInputCard(
                  title: 'Task Title',
                  child: TextFormField(
                    controller: _titleController,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          
                        ),
                    decoration: const InputDecoration(
                      hintText: 'Enter task title',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Description input
                _buildInputCard(
                  title: 'Task Description',
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                           
                        ),
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Enter task description',
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 16),

                // Start date picker
                _buildInputCard(
                  title: 'Start Date',
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                           
                        ),
                    controller: _startDateController,
                    decoration: const InputDecoration(
                      hintText: 'Select start date',
                      border: InputBorder.none,
                    ),
                    readOnly: true,
                    onTap: () => _pickStartDate(context),
                  ),
                ),
                const SizedBox(height: 16),

                // End date picker
                _buildInputCard(
                  title: 'End Date',
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                           
                        ),
                    controller: _endDateController,
                    decoration: const InputDecoration(
                      hintText: 'Select end date',
                      border: InputBorder.none,
                    ),
                    readOnly: true,
                    onTap: () => _pickEndDate(context),
                  ),
                ),
                const SizedBox(height: 16),

                // Priority dropdown
                _buildInputCard(
                  title: 'Priority',
                  child: DropdownButton<int>(
                    value: _priority,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _priority = value;
                        });
                      }
                    },
                    underline: const SizedBox(),
                    items: [1, 2, 3]
                        .map((priority) => DropdownMenuItem(
                              value: priority,
                              child: Text('Priority: $priority',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                           
                        ),),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),

                // Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveTask,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Text('Save Task',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                           
                        ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard({required String title, required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: title == 'Priority'
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  child,
              ])
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  child,
                ],
              ),
            ),
    );
  }
}
