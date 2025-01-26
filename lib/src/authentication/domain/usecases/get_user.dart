import 'package:tdd_learning_app/core/utils/typedef.dart';
import 'package:tdd_learning_app/core/usecase/usecase.dart';
import 'package:tdd_learning_app/src/authentication/domain/entities/user.dart';
import 'package:tdd_learning_app/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  final AuthenticationRepository _repository;
  GetUsers(this._repository);
  @override
  ResultFuture<List<User>> call() async => _repository.getUser();
}
