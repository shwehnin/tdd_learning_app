import 'package:dartz/dartz.dart';
import 'package:tdd_learning_app/core/errors/exceptions.dart';
import 'package:tdd_learning_app/core/errors/failure.dart';
import 'package:tdd_learning_app/core/utils/typedef.dart';
import 'package:tdd_learning_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_learning_app/src/authentication/domain/entities/user.dart';
import 'package:tdd_learning_app/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  @override
  ResultVoid createUser({required String name, required String avatar, required String createdAt}) async{
    try{
      await _remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt);
      return Right(null);
    }on APIException catch(e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUser() async{
    try{
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    }on APIException catch(e) {
      return Left(APIFailure.fromException(e));
    }
  }
}