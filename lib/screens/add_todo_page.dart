import 'package:flutter/material.dart';
import 'package:todo_app/services/todo_service.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      titleController.text = todo['title'];
      descriptionController.text = todo['description'];
    }
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;

    if (isEdit) {
      final id = widget.todo!['_id'];
      final success = await TodoService.updateTodo(id, title, description);
      success ? showMessage('Todo updated') : showMessage('Update failed');
    } else {
      final success = await TodoService.addTodo(title, description);
      success ? showMessage('Todo added') : showMessage('Add failed');
    }

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Todo' : 'Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: 'Description'),
              minLines: 5,
              maxLines: 8,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: submitData,
              child: Text(isEdit ? 'Update' : 'Submit'),
            )
          ],
        ),
      ),
    );
  }
}
