import 'package:postgres/postgres.dart';
import 'package:simple_backend/config/database_config.dart';

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
        host: DatabaseConfig.host,
        database: DatabaseConfig.database,
        username: DatabaseConfig.username,
        password: DatabaseConfig.password,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
  }
}
