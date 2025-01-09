import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:simple_backend/controllers/user_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  return switch (request.method) {
    HttpMethod.post => context.read<UserController>().addUser(context),
    HttpMethod.get => context.read<UserController>().getUsers(context),
    _ => Future.value(
        Response(statusCode: HttpStatus.methodNotAllowed),
      ),
  };
}
