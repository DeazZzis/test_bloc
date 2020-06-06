import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:testblocapp/auth/User.dart';

part 'AuthEvent.dart';

part 'AuthState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final User _user;

  AuthBloc({@required User user}) : _user = user;

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAuthStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapAuthLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapAuthLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAuthStartedToState() async* {
    final isSignedIn = await _user.isSignedIn();
    if (isSignedIn) {
      final name = await _user.getUser();
      yield AuthSuccess(name);
    } else {
      yield AuthFailure();
    }
  }

  Stream<AuthState> _mapAuthLoggedInToState() async* {
    yield AuthSuccess(await _user.getUser());
  }

  Stream<AuthState> _mapAuthLoggedOutToState() async* {
    yield AuthFailure();
    _user.signOut();
  }
}
