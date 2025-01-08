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
  Future<Response> addUser(User user) async {
    try {
      await _userService.addUser(user);
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
  Future<Response> deleteUser(String id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Response> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Response> getUsers() async {
    try {
      final usersList = await _userService.getUsers();
      return Response.json(body: usersList);
    } catch (e) {
      return Response(
        statusCode: HttpStatus.internalServerError,
        body: 'Error fetching users, details: $e',
      );
    }
  }

  @override
  Future<Response> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
