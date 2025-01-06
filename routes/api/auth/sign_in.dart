import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  try {
    final body = await request.json();

    if (body == null) {
      return Response(statusCode: HttpStatus.badRequest);
    }

    return Response.json(body: {'params': body});
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}
