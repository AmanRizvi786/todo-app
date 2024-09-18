import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_todo_page.dart';
import 'package:todo_app/services/todo_service.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchToDo();
  }

  Future<void> fetchToDo() async {
    final fetchedItems = await TodoService.fetchTodos();
    setState(() {
      items = fetchedItems ?? [];
      isLoading = false;
    });
  }

  Future<void> deleteById(String id) async {
    final success = await TodoService.deleteTodoById(id);
    if (success) {
      setState(() {
        items = items.where((item) => item['_id'] != id).toList();
      });
    } else {
      showErrorMessage('Deletion Failed');
    }
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> navigateToAddTodo() async {
    final route = MaterialPageRoute(builder: (context) => const AddTodoPage());
    await Navigator.push(context, route);
    await fetchToDo();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route =
        MaterialPageRoute(builder: (context) => AddTodoPage(todo: item));
    await Navigator.push(context, route);
    await fetchToDo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchToDo,
          child: items.isNotEmpty
              ? ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final listItem = items[index];
                    final id = listItem['_id'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Text(listItem['title']),
                          subtitle: Text(listItem['description']),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'edit') {
                                navigateToEditPage(listItem);
                              } else if (value == 'delete') {
                                deleteById(id);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text("Edit"),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text("Delete"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text("No Todo Items")),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddTodo,
        label: const Text('Add Todo'),
        backgroundColor: Color(0xFF0A7298),
        foregroundColor: Colors.white,
      ),
    );
  }
}
