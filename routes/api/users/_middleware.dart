import 'package:dart_frog/dart_frog.dart';
import 'package:simple_backend/data/data_sources/database_provider.dart';
import 'package:simple_backend/data/data_sources/impl/user_data_source_impl.dart';
import 'package:simple_backend/data/data_sources/user_data_source.dart';
import 'package:simple_backend/data/repository/user_repository_impl.dart';
import 'package:simple_backend/domain/repository/user_repository.dart';

Handler middleware(Handler handler) {
  return handler
      .use(userRepositoryProvider())
      .use(userDataSourceProvider())
      .use(databaseProvider());
}

Middleware databaseProvider() {
  return provider<DatabaseProvider>((context) => DatabaseProvider());
}

Middleware userDataSourceProvider() {
  return provider<UserDataSource>(
    (context) => UserDataSourceImpl(
      provider: context.read<DatabaseProvider>(),
    )..initialize(),
  );
}

Middleware userRepositoryProvider() {
  return provider<UserRepository>(
    (context) => UserRepositoryImpl(
      userDataSource: context.read<UserDataSource>(),
    ),
  );
}
