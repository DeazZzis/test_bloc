import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testblocapp/notes/bloc/NoteBloc.dart';
import 'package:testblocapp/notes/bloc/NoteEvent.dart';
import 'package:testblocapp/notes/bloc/NoteState.dart';

import 'AddEditScreen.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        final note = (state as NotesLoaded)
            .note
            .firstWhere((todo) => todo.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                tooltip: 'Видалити',
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<NotesBloc>(context).add(DeleteNote(note));
                  Navigator.pop(context, note);
                },
              )
            ],
          ),
          body: note == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Card(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 15.0,
                                      right: 8.0,
                                      bottom: 8.0,
                                      top: 15.0),
                                  child: Text(
                                    note.title,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 10.0, top: 6.0),
                                  child: Text(
                                    note.note,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Редагувати',
            child: Icon(Icons.edit),
            onPressed: note == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            onSave: (title, text) {
                              BlocProvider.of<NotesBloc>(context).add(
                                UpdateNote(
                                  note.copyWith(title: title, note: text),
                                ),
                              );
                            },
                            isEditing: true,
                            note: note,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
