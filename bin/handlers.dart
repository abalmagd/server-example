import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Handlers {
  static Response rootHandler(Request request) {
    return Response.ok('Hello, World!\n');
  }

  static Response todosHandler(Request request, String id) {
    final todoId = int.tryParse(id);

    final todo1 = {
      'id': 1,
      'name': 'Buy food',
    };

    final todo2 = {
      'id': 2,
      'name': 'Buy clothes',
    };

    final todos = [todo1, todo2];

    try {
      final todo = todos.firstWhere((element) => element['id'] == todoId);
      final response = {
        'status': 200,
        'message': 'Success',
        'data': todo,
      };

      return Response.ok(jsonEncode(response));
    } catch (e) {
      final response = {
        'status': 400,
        'message': 'This id does not exist!',
      };

      return Response.badRequest(body: jsonEncode(response));
    }
  }

  static Response echoHandler(Request request) {
    final message = request.params['message'];
    return Response.ok('Hello $message\n');
  }
}
