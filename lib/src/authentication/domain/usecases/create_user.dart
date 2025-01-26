import 'package:equatable/equatable.dart';
import 'package:tdd_learning_app/core/utils/typedef.dart';
import 'package:tdd_learning_app/core/usecase/usecase.dart';
import 'package:tdd_learning_app/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;
  const CreateUser(this._repository);

  @override
  ResultFuture<void> call(CreateUserParams params) async =>
      _repository.createUser(
        name: params.name,
        avatar: params.avatar,
        createdAt: params.createdAt,
      );
}

class CreateUserParams extends Equatable {
  final String name;
  final String avatar;
  final String createdAt;
  const CreateUserParams({
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [name, avatar, createdAt];
}
