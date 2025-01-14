import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:simple_backend/controllers/user_controller.dart';
import 'package:simple_backend/models/user/user.dart';
import 'package:simple_backend/services/user_service.dart';

final class UserControllerImpl implements UserController {
  final UserService _userService;

  UserControllerImpl({
    required UserService userService,
  }) : _userService = userService;

  @override
  Future<Response> addUser(RequestContext context) async {
    try {
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

      final affectedRows = await _userService.addUser(user);
      if (affectedRows == 0) {
        return Response.json(
          statusCode: HttpStatus.internalServerError,
          body: 'Failed to add user to the database',
        );
      }

      return Response.json(
        statusCode: HttpStatus.created,
        body: {'message': 'User added successfully'},
      );
    } catch (e) {
      return Response(
        statusCode: HttpStatus.internalServerError,
        body: 'Error adding user, details: $e',
      );
    }
  }

  @override
  Future<Response> deleteUser(RequestContext context, String id) async {
    try {
      final affectedRows = await _userService.deleteUser(id);
      if (affectedRows == 0) {
        return Response.json(
          statusCode: HttpStatus.notFound,
          body: 'User not found',
        );
      }

      return Response.json(body: 'User with id $id was successfully deleted!');
    } catch (e) {
      return Response(
        statusCode: HttpStatus.internalServerError,
        body: 'Error deleting user, details: $e',
      );
    }
  }

  @override
  Future<Response> getUser(RequestContext context, String id) async {
    try {
      final user = await _userService.getUser(id);
      if (user == null) {
        return Response.json(
          statusCode: HttpStatus.notFound,
          body: 'User not deleted',
        );
      }

      return Response.json(body: user);
    } catch (e) {
      return Response(
        statusCode: HttpStatus.internalServerError,
        body: 'Error getting user, details: $e',
      );
    }
  }

  @override
  Future<Response> getUsers(RequestContext context) async {
    try {
      final usersList = await _userService.getUsers();
      return Response.json(body: usersList);
    } catch (e) {
      return Response(
        statusCode: HttpStatus.internalServerError,
        body: 'Error getting users, details: $e',
      );
    }
  }

  @override
  Future<Response> updateUser(RequestContext context, String id) async {
    try {
      final existingUser = await _userService.getUser(id);
      if (existingUser == null) {
        return Response.json(
          statusCode: HttpStatus.notFound,
          body: 'User not found',
        );
      }

      final body = await context.request.json() as Map<String, dynamic>;

      if (!body.containsKey('id') ||
          !body.containsKey('name') ||
          !body.containsKey('password')) {
        return Response.json(
          statusCode: HttpStatus.badRequest,
          body: {'error': 'Missing required fields: id, name or password'},
        );
      }

      final user = User.fromJson(body);
      final affectedRows = await _userService.updateUser(user);
      if (affectedRows == 0) {
        return Response.json(
          statusCode: HttpStatus.notFound,
          body: 'User not updated',
        );
      }

      return Response.json(body: 'User with id $id successfully updated!');
    } catch (e) {
      return Response(
        statusCode: HttpStatus.internalServerError,
        body: 'Error getting user, details: $e',
      );
    }
  }
}
