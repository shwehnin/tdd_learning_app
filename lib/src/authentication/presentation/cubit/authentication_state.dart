part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable{
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();

  @override
  List<Object> get props => [];
}

final class CreatingUser extends AuthenticationState {
  const CreatingUser();

  @override
  List<Object> get props => [];
}

final class GettingUser extends AuthenticationState {
  const GettingUser();

  @override
  List<Object> get props => [];
}

final class UserCreated extends AuthenticationState {
  const UserCreated();
  @override
  List<Object> get props => [];
}

final class UsersLoaded extends AuthenticationState {
  final List<User> users;
  const UsersLoaded(this.users);

  @override
  List<Object?> get props => users.map((user) => user.id).toList();
}

final class AuthenticationError extends AuthenticationState {
  final String message;
  const AuthenticationError(this.message);

  @override
  List<Object?> get props => [message];
}