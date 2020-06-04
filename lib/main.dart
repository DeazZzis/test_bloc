import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testblocapp/pages/secondPage.dart';

import 'bloc.dart';
import 'pages/mainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (context) => NoteBloc(),
      child: MaterialApp(
        home: MainPage(),
      ),
    );
  }
}
