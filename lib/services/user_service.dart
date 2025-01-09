import 'package:simple_backend/models/user/user.dart';

abstract interface class UserService {
  Future<List<User>> getUsers();
  Future<int> addUser(User user);
  Future<User> getUser(String id);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}
