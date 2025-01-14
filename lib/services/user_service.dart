import 'package:simple_backend/models/user/user.dart';

abstract interface class UserService {
  Future<List<User>> getUsers();
  Future<int> addUser(User user);
  Future<User?> getUser(String id);
  Future<int> updateUser(User user);
  Future<int> deleteUser(String id);
}
