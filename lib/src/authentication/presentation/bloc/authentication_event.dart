part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  final String name;
  final String avatar;
  final String createdAt;

  CreateUserEvent({required this.name, required this.avatar, required this.createdAt});
  @override
  List<Object?> get props => [name, avatar, createdAt];
}

class GetUserEvent extends AuthenticationEvent {
  GetUserEvent();
}
