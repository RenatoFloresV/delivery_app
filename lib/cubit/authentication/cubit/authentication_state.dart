part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final UserModel? user;

  const AuthenticationSuccess({required this.user}) : assert(user != null);

  @override
  List<Object> get props => [user!];
}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {}

class AuthenticationLogout extends AuthenticationState {}

