import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:simple_backend/controllers/user_controller.dart';

Future<Response> onRequest(RequestContext context, String id) {
  final request = context.request;
  return switch (request.method) {
    HttpMethod.get => context.read<UserController>().getUser(context, id),
    HttpMethod.delete => context.read<UserController>().deleteUser(context, id),
    HttpMethod.put => context.read<UserController>().updateUser(context, id),
    _ => Future.value(
        Response(statusCode: HttpStatus.methodNotAllowed),
      ),
  };
}
