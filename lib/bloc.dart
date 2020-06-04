import 'package:flutter_bloc/flutter_bloc.dart';

enum NoteEvent { add, remove }

class NoteBloc extends Bloc<NoteEvent, int> {

  List<String> notes = [];

  void removeAt(int i) {
    notes.removeAt(i);
  }

  void addNote(String s) {
    notes.add(s);
  }

  @override
  Stream<int> mapEventToState(NoteEvent event) async* {
    switch (event) {
      case NoteEvent.add:
        yield state + 1;
        break;
      case NoteEvent.remove:
        yield state - 1;
        break;
    }
  }

  @override
  int get initialState => 0;
}
