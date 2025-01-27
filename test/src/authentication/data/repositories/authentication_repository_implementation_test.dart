import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_learning_app/core/errors/exceptions.dart';
import 'package:tdd_learning_app/core/errors/failure.dart';
import 'package:tdd_learning_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_learning_app/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_learning_app/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSrc extends Mock implements AuthenticationRemoteDataSource {

}
void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException = APIException(message: 'Unknown error occurred', statusCode: 500);

  group('createUser', () {
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';
    const createdAt = 'whatever.createdAt';

    test('should call the [RemoteDataSource.createUser] and complete' 'successfully when the call to the remote source is successful', () async {
      when(() => remoteDataSource.createUser(name: any(named: 'name'), avatar: any(named: 'avatar'), createdAt: any(named: 'createdAt'))).thenAnswer((_) async => Future.value());

      final result = await repoImpl.createUser(name: name, avatar: avatar, createdAt: createdAt);
      
      expect(result, equals(const Right(null)));

      verify(() => remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return a [APIFailure] when the call to the remote' 'source is unsuccessful', () async {
      // Arrange
      when(() => remoteDataSource.createUser(name: any(named: 'name'), avatar: any(named: 'avatar'), createdAt: any(named: 'createdAt'))).thenThrow(tException);

      final result = await repoImpl.createUser(name: name, avatar: avatar, createdAt: createdAt);
      
      expect(result, equals(Left(APIFailure(message : tException.message, statusCode: tException.statusCode))));

      verify(() => remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    test('should call the [RemoteDataSource.getUsers] and return [List<User>] when call to remote source is successful', () async {
      when(() => remoteDataSource.getUsers()).thenAnswer((_) async => [] );

      final result = await repoImpl.getUser();
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
    
    test('should return a [APIFailure] when the call to the remote' 'source is unsuccessful', () async{
      when(() => remoteDataSource.getUsers()).thenThrow(tException);
      
      final result = await repoImpl.getUser();
      expect(result, equals(Left(APIFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}