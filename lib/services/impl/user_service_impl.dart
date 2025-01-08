import 'package:simple_backend/models/user/user.dart';
import 'package:simple_backend/repositories/user_repository.dart';
import 'package:simple_backend/services/user_service.dart';

final class UserServiceImpl implements UserService {
  final UserRepository _userRepository;

  UserServiceImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<void> addUser(User user) async {
    await _userRepository.addUser(user);
  }

  @override
  Future<void> deleteUser(String id) async {
    await _userRepository.deleteUser(id);
  }

  @override
  Future<User> getUser(String id) {
    return _userRepository.getUser(id);
  }

  @override
  Future<List<User>> getUsers() {
    return _userRepository.getUsers();
  }

  @override
  Future<void> updateUser(User user) async {
    await _userRepository.updateUser(user);
  }
}
