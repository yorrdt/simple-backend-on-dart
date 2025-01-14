import 'package:simple_backend/core/constants/user_database_constants.dart';
import 'package:simple_backend/models/user/user.dart';
import 'package:simple_backend/repositories/database_connection.dart';
import 'package:simple_backend/repositories/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  final DatabaseConnection _databaseConnection;

  const UserRepositoryImpl({
    required DatabaseConnection databaseConnection,
  }) : _databaseConnection = databaseConnection;

  Future<void> initialize() async {
    await _createUserTable();
  }

  Future<void> _createUserTable() async {
    final db = await _databaseConnection.open();
    try {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS ${UserDatabaseConstants.databaseName} ('
        '${UserDatabaseConstants.id} uuid default gen_random_uuid() primary key,'
        '${UserDatabaseConstants.name} varchar(255) not null,'
        '${UserDatabaseConstants.password} text not null'
        ')',
      );
    } catch (e) {
      await db.close();
      throw Exception(e);
    }
  }

  @override
  Future<int> addUser(User user) async {
    final db = await _databaseConnection.open();
    try {
      final result = await db.execute(
        'INSERT INTO ${UserDatabaseConstants.databaseName}'
        '(${UserDatabaseConstants.name}, ${UserDatabaseConstants.password})'
        r' VALUES ($1, $2)',
        parameters: [user.name, user.password],
      );

      return result.affectedRows;
    } catch (e) {
      await db.close();
      throw Exception(e);
    }
  }

  @override
  Future<int> deleteUser(String id) async {
    final db = await _databaseConnection.open();
    try {
      final result = await db.execute(
        'DELETE FROM ${UserDatabaseConstants.databaseName} '
        'WHERE ${UserDatabaseConstants.id} = \$1',
        parameters: [id],
      );

      return result.affectedRows;
    } catch (e) {
      await db.close();
      throw Exception(e);
    }
  }

  @override
  Future<User?> getUser(String id) async {
    final db = await _databaseConnection.open();
    try {
      final result = await db.execute(
        'SELECT * FROM ${UserDatabaseConstants.databaseName} '
        'WHERE ${UserDatabaseConstants.id} = \$1',
        parameters: [id],
      );

      if (result.isEmpty) return null;

      return User.fromJson(result.first.toColumnMap());
    } catch (e) {
      await db.close();
      throw Exception(e);
    }
  }

  @override
  Future<List<User>> getUsers() async {
    final db = await _databaseConnection.open();
    try {
      final result = await db.execute(
        'SELECT * FROM ${UserDatabaseConstants.databaseName}',
      );

      return result.map((row) => User.fromJson(row.toColumnMap())).toList();
    } catch (e) {
      await db.close();
      throw Exception(e);
    }
  }

  @override
  Future<int> updateUser(User user) async {
    final db = await _databaseConnection.open();
    try {
      final result = await db.execute(
        'UPDATE ${UserDatabaseConstants.databaseName} '
        r'SET name = $1, password = $2 '
        'WHERE ${UserDatabaseConstants.id} = \$3',
        parameters: [user.name, user.password, user.id],
      );

      return result.affectedRows;
    } catch (e) {
      await db.close();
      throw Exception(e);
    }
  }
}
