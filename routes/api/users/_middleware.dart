import 'package:dart_frog/dart_frog.dart';
import 'package:simple_backend/database_provider.dart';
import 'package:simple_backend/repositories/impl/user_repository_impl.dart';
import 'package:simple_backend/repositories/user_repository.dart';
import 'package:simple_backend/services/impl/user_service_impl.dart';
import 'package:simple_backend/services/user_service.dart';

Handler middleware(Handler handler) {
  return handler
      .use(userServiceProvider())
      .use(userRepositoryProvider())
      .use(databaseProvider());
}

Middleware databaseProvider() {
  return provider<DatabaseProvider>((context) => DatabaseProvider());
}

Middleware userRepositoryProvider() {
  return provider<UserRepository>(
    (context) => UserRepositoryImpl(
      databaseProvider: context.read<DatabaseProvider>(),
    )..initialize(),
  );
}

Middleware userServiceProvider() {
  return provider<UserService>(
    (context) => UserServiceImpl(
      userRepository: context.read<UserRepository>(),
    ),
  );
}
