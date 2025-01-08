import 'package:simple_backend/database_provider.dart';
import 'package:simple_backend/models/user/user.dart';
import 'package:simple_backend/repositories/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  final DatabaseProvider _databaseProvider;

  const UserRepositoryImpl({
    required DatabaseProvider databaseProvider,
  }) : _databaseProvider = databaseProvider;

  Future<void> initialize() async {
    await _createUserTable();
  }

  Future<void> _createUserTable() async {
    final db = await _databaseProvider.connection;
    await db.execute(
      'CREATE TABLE IF NOT EXISTS users ('
      'id uuid default gen_random_uuid() primary key,'
      'name varchar(255) not null,'
      'password text not null'
      ')',
    );
  }

  @override
  Future<void> addUser(User user) async {
    final db = await _databaseProvider.connection;
    await db.execute(
      r'INSERT INTO users(name, password) VALUES ($1, $2)',
      parameters: [user.name, user.password],
    );
  }

  @override
  Future<void> deleteUser(String id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getUsers() async {
    final db = await _databaseProvider.connection;
    final result = await db.execute('SELECT * FROM users');

    for (var item in result) {
      print(item);
    }

    return result.map((row) => User.fromJson(row.toColumnMap())).toList();
  }

  @override
  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
