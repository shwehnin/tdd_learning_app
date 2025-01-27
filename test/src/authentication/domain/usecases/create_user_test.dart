import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_learning_app/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_learning_app/src/authentication/domain/repositories/authentication_repository.dart';

import 'authentication_repository.mock.dart';


void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;
  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });
  const params = CreateUserParams.empty();
  test('should call the [AuthRepo.createUser]', () async {
    // Arrange
    when(
      () => repository.createUser(
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
        createdAt: any(named: 'createdAt'),
      ),
    ).thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
      () => repository.createUser(
        name: params.name,
        avatar: params.avatar,
        createdAt: params.createdAt,
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
