import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_learning_app/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_learning_app/src/authentication/domain/usecases/get_user.dart';

import '../../domain/entities/user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;
  AuthenticationCubit({required CreateUser createUser, required GetUsers getUsers}) :
        _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial());

  Future<void> createUser({required String name, required String avatar, required String createdAt}) async {
    emit(CreatingUser());
    final result = await _createUser(CreateUserParams(name: name, avatar: avatar, createdAt: createdAt));
    
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)), (_) => emit(UserCreated()));
  }

  Future<void> getUsers() async {
    emit(GettingUser());
    final result = await _getUsers();
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)), (users) => emit(UsersLoaded(users)));
  }
}
