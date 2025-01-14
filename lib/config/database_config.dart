import 'package:dotenv/dotenv.dart';

final class DatabaseConfig {
  static final DotEnv _dotEnv = DotEnv()..load();

  DatabaseConfig._();

  static final String host = _dotEnv['DATABASE_HOST'] ?? 'localhost';
  static final int port = int.tryParse(_dotEnv['DATABASE_PORT'] ?? '') ?? 5432;
  static final String database = _dotEnv['DATABASE_NAME'] ?? 'test';
  static final String username = _dotEnv['DATABASE_USERNAME'] ?? 'postgres';
  static final String password = _dotEnv['DATABASE_PASSWORD'] ?? 'postgres';
}
