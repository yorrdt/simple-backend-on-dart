import 'package:simple_backend/domain/models/user/user.dart';

abstract interface class UserDataSource {
  Future<List<User>> getUsers();
  Future<void> addUser(User user);
  Future<User> getUser(String id);
}
