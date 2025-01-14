import 'package:postgres/postgres.dart';
import 'package:simple_backend/config/database_config.dart';

final class DatabaseConnection {
  Connection? _connection;

  Future<Connection> open() async {
    if (_connection != null) return _connection!;

    _connection = await _openConnection();
    return _connection!;
  }

  Future<Connection> _openConnection() {
    return Connection.open(
      Endpoint(
        host: DatabaseConfig.host,
        port: DatabaseConfig.port,
        database: DatabaseConfig.database,
        username: DatabaseConfig.username,
        password: DatabaseConfig.password,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
  }

  Future<void> close() => _connection!.close();
}
