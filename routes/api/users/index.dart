import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:simple_backend/domain/models/user/user.dart';
import 'package:simple_backend/domain/repository/user_repository.dart';

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
  final username = body['username'] as String?;
  final password = body['password'] as String?;

  if (username == null || password == null) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  final user = User(name: username, password: password);

  final userRepository = context.read<UserRepository>();
  await userRepository.addUser(user);

  return Response.json(body: {'message': 'create user'});
}

Future<Response> _onGet(RequestContext context) async {
  final userRepository = context.read<UserRepository>();
  final users = await userRepository.getUsers();

  return Response.json(body: {'message': users});
}
