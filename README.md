# Task Management App

## Overview
This is a task management application built with Flutter and Riverpod for state management. It allows users to add, edit, delete, and manage tasks by separating them into "Pending" and "Completed" categories. Users can also sort tasks by date or priority based on their preferences.

## Features
- Add new tasks with details (title, description, start date, end date, and priority).
- Edit existing tasks.
- Delete tasks.
- Toggle tasks between "Pending" and "Completed" using a switch button.
- Sort tasks by date or priority via preferences.
- Navigate between "Pending" and "Completed" tasks using tabs.

---

## Prerequisites
Ensure the following tools are installed:

1. **Flutter SDK**
   - [Download and install Flutter](https://docs.flutter.dev/get-started/install).

2. **Dart**
   - Dart is included with Flutter, so no separate installation is needed.

3. **Android Studio/Xcode**
   - Install Android Studio (for Android) or Xcode (for iOS) as per your development requirements.

4. **Device/Emulator**
   - Set up a physical device or emulator to run the application.

---

## Installation

### Clone the Repository
Run the following command in your terminal to clone the repository:
```bash
git clone https://github.com/Vivek-Jadhav27/Task-Management-App.git
```

Navigate into the project directory:
```bash
cd task_management_app
```

### Install Dependencies
Run the following command to fetch all required dependencies:
```bash
flutter pub get
```

---

## Running the App

### Android
1. Open the project in Android Studio or run the following command in the terminal:
   ```bash
   flutter run
   ```
2. Make sure your device/emulator is connected and recognized by Flutter.

### iOS
1. Ensure Xcode is installed.
2. Open the project in Xcode or run the following command in the terminal:
   ```bash
   flutter run
   ```
3. Make sure your iOS device/simulator is running and recognized by Flutter.

---

## Directory Structure
The project follows a feature-first directory structure:

```
lib/
|- helpers/              # Database helper class
|- utils/                # Constants and utility classes
|- models/               # Task model and data-related classes
|- repositories/         # Data access layer
|- viewmodels/           # State management (Riverpod providers)
|- views/                # Screens and UI components
|- main.dart             # App entry point
```

---

## Usage

### Add Task
1. Tap the floating action button (FAB) on the home screen.
2. Fill in task details.
3. Tap "Save" to add the task.

### Edit Task
1. Tap a task from the list.
2. Make changes to the task.
3. Tap "Save" to update the task.

### Delete Task
1. Tap the "Delete" button below the task description.

### Toggle Task Status
1. Use the switch button to mark tasks as "Completed" or "Pending."

### Change Sort Preferences
1. Navigate to the preferences screen using the settings icon.
2. Choose sorting order ("Date" or "Priority").
3. Tasks will be sorted accordingly.

---

## Troubleshooting
If you encounter issues while running the app, try the following steps:

1. Ensure all dependencies are installed:
   ```bash
   flutter pub get
   ```
2. Check for any pending updates:
   ```bash
   flutter upgrade
   ```
3. Verify connected devices:
   ```bash
   flutter devices
   ```
4. Run the app with verbose logging to diagnose errors:
   ```bash
   flutter run --verbose
   ```

For additional help, refer to the [Flutter documentation](https://docs.flutter.dev/).

