import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:simple_backend/controllers/user_controller.dart';
import 'package:simple_backend/models/user/user.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  return switch (request.method) {
    HttpMethod.post => _onPost(context),
    HttpMethod.get => _onGet(context),
    _ => Future.value(
        Response(statusCode: HttpStatus.methodNotAllowed),
      ),
  };
}

Future<Response> _onPost(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;

  if (!body.containsKey('username') || !body.containsKey('password')) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'error': 'Missing required fields: username or password'},
    );
  }

  final username = body['username'] as String;
  final password = body['password'] as String;

  final user = User(name: username, password: password);

  final userController = context.read<UserController>();
  return userController.addUser(user);
}

Future<Response> _onGet(RequestContext context) async {
  final userController = context.read<UserController>();
  return userController.getUsers();
}
