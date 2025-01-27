import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_learning_app/core/errors/failure.dart';
import 'package:tdd_learning_app/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_learning_app/src/authentication/domain/usecases/get_user.dart';
import 'package:tdd_learning_app/src/authentication/presentation/cubit/authentication_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tAPIFailure = APIFailure(message: 'error message', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());
  
  test('initial state should be [AuthenticationInitial] ', () async {
    expect(cubit.state, AuthenticationInitial());
  });
  
  group('createUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>('should emit [CreatingUser, UserCreated] when successful', build: () {
      when(() => createUser(any())).thenAnswer(
          (_) async => Right(null),
      );
      return cubit;
    }, act: (cubit) => cubit.createUser(name: tCreateUserParams.name, avatar: tCreateUserParams.avatar, createdAt: tCreateUserParams.createdAt),
        expect: () => [
      CreatingUser(),
      UserCreated(),
    ], verify: (_) {
      verify(() => createUser(tCreateUserParams)).called(1);
      verifyNoMoreInteractions(createUser);
    });

    blocTest<AuthenticationCubit, AuthenticationState>('should emit [CreatingUser, AuthenticationError] when unsuccessful', build: () {
      when(() => createUser(any())).thenAnswer(
          (_) async => const Left(tAPIFailure),
      );
      return cubit;
    }, act: (cubit) => cubit.createUser(name: tCreateUserParams.name, avatar: tCreateUserParams.avatar, createdAt: tCreateUserParams.createdAt), expect: () => [
      CreatingUser(),
      AuthenticationError(tAPIFailure.errorMessage)
    ], verify: (_) {
      verify(() => createUser(tCreateUserParams)).called(1);
      verifyNoMoreInteractions(createUser);
    });
  });
  
  group('getUsers', () {
    blocTest<AuthenticationCubit, AuthenticationState>('should emit [GettingUser, UsersLoaded] when successful', build: () {
      when(() => getUsers()).thenAnswer((_) async => Right([]));
      return cubit;
    }, act: (cubit) => cubit.getUsers(),
    expect: () => [
      GettingUser(),
      UsersLoaded([]),
    ], verify: (_) {
      verify(() => getUsers()).called(1);
      verifyNoMoreInteractions(getUsers);
        });

    blocTest<AuthenticationCubit, AuthenticationState>('should emit [GettingUsers, AuthenticationError] when unsuccessful', build: () {
      when(() => getUsers()).thenAnswer((_) async => Left(tAPIFailure));
      return cubit;
    }, act: (cubit) => cubit.getUsers(),
    expect: () => [
      GettingUser(),
      AuthenticationError(tAPIFailure.errorMessage),
    ], verify: (_) {
      verify(() => getUsers()).called(1);
      verifyNoMoreInteractions(getUsers);
        });
  });
}