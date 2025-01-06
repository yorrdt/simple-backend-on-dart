import 'package:postgres/postgres.dart';

final class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  static Connection? _connection;

  DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _instance;
  }

  Future<Connection> get connection async {
    if (_connection != null) return _connection!;

    _connection = await _openConnection();
    return _connection!;
  }

  Future<Connection> _openConnection() {
    return Connection.open(
      Endpoint(
        host: 'localhost',
        database: 'dart-test',
        username: 'postgres',
        password: 'postgres',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
  }
}
