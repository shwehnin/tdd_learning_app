import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tdd_learning_app/src/authentication/domain/entities/user.dart';
import 'package:tdd_learning_app/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_learning_app/src/authentication/domain/usecases/get_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required CreateUser createUser, required GetUsers getUser}) :
        _createUser = createUser,
        _getUsers = getUser,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(CreateUserEvent event, Emitter<AuthenticationState> emit) async{
    emit(CreatingUser());

    final result = await _createUser(
      CreateUserParams(name: event.name, avatar: event.avatar, createdAt: event.createdAt)
    );
    
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)), (_) => emit(UserCreated()));
  }

  Future<void> _getUserHandler(GetUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(GettingUser());

    final result = await _getUsers();
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)), (users) => emit(UsersLoaded(users)));
  }
}
