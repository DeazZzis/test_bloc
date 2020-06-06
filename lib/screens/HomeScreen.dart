import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testblocapp/notes/bloc/NoteBloc.dart';
import 'package:testblocapp/notes/bloc/NoteEvent.dart';
import 'package:testblocapp/notes/bloc/NoteState.dart';
import 'package:testblocapp/screens/DetailsScreen.dart';
import 'package:testblocapp/widgets/DeleteNoteSnackBar.dart';
import 'package:testblocapp/widgets/NoteItem.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Нотатки'),
      ),
      body: notes(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addNote');
        },
        child: Icon(Icons.add),
        tooltip: 'Додати',
      ),
    );
  }

  Widget notes() {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesLoading) {
          return CircularProgressIndicator();
        } else if (state is NotesLoaded) {
          final notes = state.note;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteItem(
                note: note,
                onDismissed: (direction) {
                  BlocProvider.of<NotesBloc>(context).add(DeleteNote(note));
                  Scaffold.of(context).showSnackBar(DeleteNoteSnackBar(
                    note: note,
                    onUndo: () =>
                        BlocProvider.of<NotesBloc>(context).add(AddNote(note)),
                  ));
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: note.id);
                    }),
                  );
                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(
                      DeleteNoteSnackBar(
                        note: note,
                        onUndo: () => BlocProvider.of<NotesBloc>(context)
                            .add(AddNote(note)),
                      ),
                    );
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<NotesBloc>(context).add(
                    UpdateNote(note.copyWith()),
                  );
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
