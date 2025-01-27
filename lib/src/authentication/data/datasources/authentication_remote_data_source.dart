import 'dart:convert';

import 'package:tdd_learning_app/core/errors/exceptions.dart';
import 'package:tdd_learning_app/core/utils/constants.dart';
import 'package:tdd_learning_app/core/utils/typedef.dart';
import 'package:tdd_learning_app/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/users';
const kGetUserEndpoint = '/users';

class AuthRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final http.Client _client;

  const AuthRemoteDataSourceImpl(this._client);

  @override
  Future<void> createUser({required String name, required String avatar, required String createdAt}) async{
    try{
      final response = await _client.post(Uri.https(kBaseUrl, kCreateUserEndpoint), body: jsonEncode({
        'name': name,
        'avatar': avatar,
        'createdAt': createdAt,
      }), headers: {
        'Content-Type': 'application/json'
      });
      if(response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(message: response.body, statusCode: response.statusCode);
      }
    }on APIException {
      rethrow;
    }
    catch(e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async{
    try{
      final response = await _client.get(Uri.https(kBaseUrl, kGetUserEndpoint));
      if(response.statusCode != 200) {
        throw APIException(message: response.body, statusCode: response.statusCode);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List).map((userData) => UserModel.fromMap(userData)).toList();

    }on APIException {
      rethrow;
    }catch(e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
  
}