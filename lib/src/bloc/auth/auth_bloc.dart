import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/src/constants/auth.dart';
import 'package:flutter_template/src/repository/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepo,
  })  : _authRepo = authRepo,
        super(const AuthState.unknown()) {
    _authenticationStatusSubscription = _authRepo.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthRepository _authRepo;
  late StreamSubscription<AuthStatus> _authenticationStatusSubscription;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is LogoutRequested) {
      _authRepo.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authRepo.dispose();
    return super.close();
  }

  Future<AuthState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return const AuthState.unauthenticated();
      case AuthStatus.authenticated:
        // Todo: Do something next
        // final user = await _tryGetUser();
        // return user != null
        //     ? AuthState.authenticated(user)
        //     : const AuthState.unauthenticated();
        return const AuthState.authenticated();
      default:
        return const AuthState.unknown();
    }
  }
}
