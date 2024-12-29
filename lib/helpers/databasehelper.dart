import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/task_model.dart';

class DatabaseHelper {

  static const  _databaseName = "TaskDB.db";
  static const _databaseVersion = 1;
  static const table = 'tasks';

  // Column names
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnIsCompleted = 'isCompleted';
  static const columnStartDate = 'startDate';
  static const columnEndDate = 'endDate';
  static const columnPriority = 'priority';

  // Singleton instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // Database getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Create table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT,
        $columnIsCompleted INTEGER NOT NULL DEFAULT 0,
        $columnStartDate TEXT NOT NULL,    
        $columnEndDate TEXT NOT NULL,      
        $columnPriority INTEGER NOT NULL DEFAULT 3 
      )
    ''');
  }

  // Insert a task
  Future<void> insertTask(Task task) async {
    final db = await database;
    try {
      await db.insert(
        table,
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('Task inserted successfully');
    } catch (e) {
      debugPrint('Error inserting task: $e');
    }
  }

  // Fetch all tasks
  Future<List<Task>> fetchAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  // Fetch tasks with a filter (e.g., completed tasks)
  Future<List<Task>> fetchFilteredTasks({required int isCompleted}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: '$columnIsCompleted = ?',
      whereArgs: [isCompleted],
    );
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  // Update a task
  Future<void> updateTask(Task task) async {
    final db = await database;
    try {
      await db.update(
        table,
        task.toMap(),
        where: '$columnId = ?',
        whereArgs: [task.id],
      );
      debugPrint('Task updated successfully');
    } catch (e) {
      debugPrint('Error updating task: $e');
    }
  }

  // Delete a task
  Future<void> deleteTask(int id) async {
    final db = await database;
    try {
      await db.delete(
        table,
        where: '$columnId = ?',
        whereArgs: [id],
      );
      debugPrint('Task deleted successfully');
    } catch (e) {
      debugPrint('Error deleting task: $e');
    }
  }

  // Count total tasks
  Future<int> countTasks() async {
    final db = await database;
    try {
      return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'),
      )!;
    } catch (e) {
      debugPrint('Error counting tasks: $e');
      return 0;
    }
  }
}