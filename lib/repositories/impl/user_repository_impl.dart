import 'package:simple_backend/constants/user_database_constants.dart';
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
      'CREATE TABLE IF NOT EXISTS ${UserDatabaseConstants.databaseName} ('
      '${UserDatabaseConstants.id} uuid default gen_random_uuid() primary key,'
      '${UserDatabaseConstants.name} varchar(255) not null,'
      '${UserDatabaseConstants.password} text not null'
      ')',
    );
  }

  @override
  Future<int> addUser(User user) async {
    try {
      final db = await _databaseProvider.connection;
      final result = await db.execute(
        r'INSERT INTO users(name, password) VALUES ($1, $2)',
        parameters: [user.name, user.password],
      );

      return result.affectedRows;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    final db = await _databaseProvider.connection;
    await db.execute(
      r'DELETE FROM users WHERE id = $1',
      parameters: [id],
    );
  }

  @override
  Future<User> getUser(String id) async {
    final db = await _databaseProvider.connection;
    final result = await db.execute(
      r'SELECT * FROM users WHERE id = $1',
      parameters: [id],
    );
    return User.fromJson(result.first.toColumnMap());
  }

  @override
  Future<List<User>> getUsers() async {
    final db = await _databaseProvider.connection;
    final result = await db.execute(
      'SELECT * FROM ${UserDatabaseConstants.databaseName}',
    );

    return result.map((row) => User.fromJson(row.toColumnMap())).toList();
  }

  @override
  Future<void> updateUser(User user) async {
    final db = await _databaseProvider.connection;
    await db.execute(
      r'UPDATE users name = $1, password = $2 WHERE id = $3',
      parameters: [user.name, user.password, user.id],
    );
  }
}
