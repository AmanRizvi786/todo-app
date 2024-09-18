# Contact
Author: Aman Rizvi
Email: amanrizvi785@gmail.com

# todo_app

A simple and intuitive To-Do App built using Flutter, integrating a REST API to perform Create, Read, Update, and Delete (CRUD) operations. The app is designed to help users manage their tasks efficiently with a clean UI and seamless functionality.

# Features

Add New Tasks: Create new to-do items.
View Tasks: Display all tasks in a clean and organized list.
Update Tasks: Modify existing tasks with ease.
Delete Tasks: Remove tasks when completed or no longer needed.
API Integration: Uses REST API for syncing data.
Persistent Data: Tasks are stored persistently and can be fetched when reopening the app.

# Technologies Used
Flutter: The main framework used to build the app.
Dart: The programming language used with Flutter.
REST API: For handling all CRUD operations.
HTTP Package: To handle API calls.

## Getting Started

# Prerequisites

To run this project, ensure you have:

Flutter installed (Flutter Installation Guide).
A suitable IDE (Android Studio, VS Code) with Flutter and Dart plugins.
Access to an API that supports CRUD operations for to-do items. If you're using a custom backend, set up the backend server before running the app.

# API Endpoints
This app interacts with a REST API to manage the to-do tasks. The following endpoints are used:

GET /tasks: Fetch all tasks.
POST /tasks: Create a new task.
PUT /tasks/{id}: Update a specific task.
DELETE /tasks/{id}: Delete a specific task.

# Sample API Response
Here’s a sample JSON structure for the tasks:

json
{
  "id": 1,
  "title": "Complete Flutter project",
  "description": "Work on the to-do app project with API integration",
  "isCompleted": false
}

# Folder Structure

lib/screens/: Contains all the UI screens such as task list, add/edit task.
models/: Defines the data models (e.g., Task).
services/: Contains the API service for handling HTTP requests.
widgets/: Custom widgets used across the app.

# Dependencies
This project uses the following Flutter packages:

http: For making HTTP requests to the REST API.

# todo-app-using-API


