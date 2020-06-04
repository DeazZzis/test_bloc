import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testblocapp/bloc.dart';
import 'package:testblocapp/pages/secondPage.dart';

class MainPage extends StatelessWidget {
  MainPage({this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    final NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);

    if (text != null) {
      noteBloc.addNote(text);
      noteBloc.add(NoteEvent.add);
      text = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Нотатки"),
      ),
      body: BlocBuilder(
        bloc: noteBloc,
        builder: (BuildContext context, int state) {
          if (noteBloc.state != null) {
            return ListView.builder(
                itemCount: state,
                itemBuilder: (context, i) {
                  return Container(
                    child: Card(
                        child: ListTile(
                      onTap: () {
                        String text = noteBloc.notes[i];
                        noteBloc.removeAt(i);
                        noteBloc.add(NoteEvent.remove);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(text: text)),
                        );
                      },
                      title: Text(
                        noteBloc.notes[i].split('\n')[0],
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          noteBloc.removeAt(i);
                          noteBloc.add(NoteEvent.remove);
                        },
                      ),
                    )),
                  );
                });
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPage()),
            );
          }),
    );
  }
}
