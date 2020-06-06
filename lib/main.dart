import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testblocapp/auth/bloc/AuthBloc.dart';
import 'package:testblocapp/auth/User.dart';
import 'package:testblocapp/auth/SplashScreen.dart';
import 'auth/login/LoginScreen.dart';
import 'pages/mainPage.dart';

void main() {
  final User user = User();
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(
        user: user,
      )..add(AppStarted()),
      child: App(user: user),
    ),
  );
}

class App extends StatelessWidget {
  final User _user;

  App({@required User user}) : _user = user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthFailure) {
            return LoginScreen(user: _user);
          }
          if (state is AuthSuccess) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return MainPage();
              }));
            });
          }
          return SplashScreen();
        },
      ),
    );
  }
}
