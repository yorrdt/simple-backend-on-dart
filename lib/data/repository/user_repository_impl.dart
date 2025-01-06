import 'package:simple_backend/data/data_sources/user_data_source.dart';
import 'package:simple_backend/domain/models/user/user.dart';
import 'package:simple_backend/domain/repository/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;

  const UserRepositoryImpl({
    required UserDataSource userDataSource,
  }) : _userDataSource = userDataSource;

  @override
  Future<void> addUser(User user) async {
    await _userDataSource.addUser(user);
  }

  @override
  Future<User> getUser(String id) async {
    return _userDataSource.getUser(id);
  }

  @override
  Future<List<User>> getUsers() {
    return _userDataSource.getUsers();
  }
}
