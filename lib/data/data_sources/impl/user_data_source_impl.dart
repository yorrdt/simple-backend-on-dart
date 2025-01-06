import 'package:simple_backend/data/data_sources/database_provider.dart';
import 'package:simple_backend/data/data_sources/user_data_source.dart';
import 'package:simple_backend/domain/models/user/user.dart';

final class UserDataSourceImpl implements UserDataSource {
  final DatabaseProvider _databaseProvider;

  const UserDataSourceImpl({
    required DatabaseProvider provider,
  }) : _databaseProvider = provider;

  Future<void> initialize() async {
    await _createUserTable();
  }

  Future<void> _createUserTable() async {
    final db = await _databaseProvider.connection;
    await db.execute('CREATE TABLE IF NOT EXISTS users ('
        'id uuid default gen_random_uuid() primary key,'
        'name varchar(255) not null,'
        'password text not null'
        ')');
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
  Future<User> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getUsers() async {
    final db = await _databaseProvider.connection;
    final result = await db.execute('SELECT * FROM users');
    return result
        .map((user) => User.fromJson(user as Map<String, dynamic>))
        .toList();
  }
}
