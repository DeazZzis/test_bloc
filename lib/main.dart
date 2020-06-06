import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testblocapp/auth/bloc/AuthBloc.dart';
import 'package:testblocapp/auth/User.dart';
import 'package:testblocapp/auth/SplashScreen.dart';
import 'package:testblocapp/screens/AddEditScreen.dart';
import 'package:testblocapp/screens/HomeScreen.dart';
import 'auth/login/LoginScreen.dart';
import 'notes/FirebaseNotes.dart';
import 'notes/bloc/NoteBloc.dart';
import 'notes/bloc/NoteEvent.dart';
import 'notes/models/Note.dart';

void main() {
  final User user = User();
  runApp(App(user: user));
}

class App extends StatelessWidget {
  final User _user;

  App({@required User user}) : _user = user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc(
              user: _user,
            )..add(AppStarted());
          },
        ),
        BlocProvider<NotesBloc>(
          create: (context) {
            return NotesBloc(
              firebaseNote: FirebaseNote(),
            )..add(LoadNotes());
          },
        )
      ],
      child: MaterialApp(
        title: 'Notes',
        routes: {
          '/': (context) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                    return HomeScreen();
                }
                if (state is AuthFailure) {
                  return LoginScreen(user: _user);
                }
                return SplashScreen();
              },
            );
          },
          '/addNote': (context) {
            return AddEditScreen(
              onSave: (title, note) {
                BlocProvider.of<NotesBloc>(context).add(
                  AddNote(Note(title, note: note)),
                );
              },
              isEditing: false,
            );
          },
        },
      ),
    );
  }
}
