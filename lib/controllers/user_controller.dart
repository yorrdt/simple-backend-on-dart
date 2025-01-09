import 'package:dart_frog/dart_frog.dart';
import 'package:simple_backend/models/user/user.dart';

abstract interface class UserController {
  Future<Response> getUsers(RequestContext context);
  Future<Response> addUser(RequestContext context);
  Future<Response> getUser(RequestContext context, String id);
  Future<Response> updateUser(RequestContext context, User user);
  Future<Response> deleteUser(RequestContext context, String id);
}
