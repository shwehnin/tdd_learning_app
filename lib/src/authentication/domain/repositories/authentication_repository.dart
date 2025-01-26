import 'package:tdd_learning_app/core/utils/typedef.dart';
import 'package:tdd_learning_app/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  ResultFuture<List<User>> getUser();
}
