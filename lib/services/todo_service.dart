import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoService {
  static const String baseUrl = 'https://api.nstack.in/v1/todos';

  // Fetch todos
  static Future<List?> fetchTodos() async {
    final uri = Uri.parse('$baseUrl?page=1&limit=10');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      return json['items'] as List;
    } else {
      return null;
    }
  }

  // Add new todo
  static Future<bool> addTodo(String title, String description) async {
    final body = jsonEncode({
      "title": title,
      "description": description,
      "is_completed": false
    });
    final uri = Uri.parse(baseUrl);
    final response = await http.post(
      uri,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 201;
  }

  // Update existing todo
  static Future<bool> updateTodo(String id, String title, String description) async {
    final body = jsonEncode({
      "title": title,
      "description": description,
      "is_completed": false
    });
    final uri = Uri.parse('$baseUrl/$id');
    final response = await http.put(
      uri,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200;
  }

  // Delete a todo
  static Future<bool> deleteTodoById(String id) async {
    final uri = Uri.parse('$baseUrl/$id');
    final response = await http.delete(uri);

    return response.statusCode == 200;
  }
}
