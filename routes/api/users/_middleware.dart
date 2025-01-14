import 'package:dart_frog/dart_frog.dart';
import 'package:simple_backend/controllers/impl/user_controller_impl.dart';
import 'package:simple_backend/controllers/user_controller.dart';
import 'package:simple_backend/repositories/database_connection.dart';
import 'package:simple_backend/repositories/impl/user_repository_impl.dart';
import 'package:simple_backend/repositories/user_repository.dart';
import 'package:simple_backend/services/impl/user_service_impl.dart';
import 'package:simple_backend/services/user_service.dart';

Handler middleware(Handler handler) {
  return handler
      .use(userControllerProvider())
      .use(userServiceProvider())
      .use(userRepositoryProvider())
      .use(databaseConnectionProvider());
}

Middleware databaseConnectionProvider() {
  return provider<DatabaseConnection>((context) => DatabaseConnection());
}

Middleware userRepositoryProvider() {
  return provider<UserRepository>(
    (context) => UserRepositoryImpl(
      databaseConnection: context.read<DatabaseConnection>(),
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

Middleware userControllerProvider() {
  return provider<UserController>(
    (context) => UserControllerImpl(
      userService: context.read<UserService>(),
    ),
  );
}
