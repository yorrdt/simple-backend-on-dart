import 'package:dart_frog/dart_frog.dart';
import 'package:simple_backend/models/user/user.dart';

abstract interface class UserController {
  Future<Response> getUsers();
  Future<Response> addUser(User user);
  Future<Response> getUser(String id);
  Future<Response> updateUser(User user);
  Future<Response> deleteUser(String id);
}
