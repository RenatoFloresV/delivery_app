import 'package:bloc/bloc.dart';
import 'package:delivery_app/models/user_model.dart';
import 'package:delivery_app/services/repositories/authentication/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
final AuthService _authService = AuthService.instante();

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthenticationInProgress());
      final UserModel? user = await _authService.signInWithGoogle();
      if (user != null) {
        emit(AuthenticationSuccess(user: user));
      } else {
        emit(AuthenticationFailure());
      }
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }

  Future<void> signOut() async {
    _authService.signOut();
    emit(AuthenticationLogout());
  }
}
