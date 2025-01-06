import 'package:simple_backend/domain/models/user/user.dart';

abstract interface class UserRepository {
  Future<List<User>> getUsers();
  Future<void> addUser(User user);
  Future<User> getUser(String id);
}
