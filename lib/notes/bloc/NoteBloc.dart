import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:testblocapp/notes/FirebaseNotes.dart';
import 'NoteEvent.dart';
import 'NoteState.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final FirebaseNote _firebaseNote;
  StreamSubscription _notesSubscription;

  NotesBloc({@required FirebaseNote firebaseNote})
      : _firebaseNote = firebaseNote;

  @override
  NotesState get initialState => NotesLoading();

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    if (event is LoadNotes) {
      yield* _mapLoadNotesToState();
    } else if (event is AddNote) {
      yield* _mapAddNoteToState(event);
    } else if (event is UpdateNote) {
      yield* _mapUpdateNoteToState(event);
    } else if (event is DeleteNote) {
      yield* _mapDeleteNoteToState(event);
    } else if (event is NotesUpdated) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<NotesState> _mapLoadNotesToState() async* {
    _notesSubscription?.cancel();
    _notesSubscription = _firebaseNote.notes().listen(
          (notes) => add(NotesUpdated(notes)),
        );
  }

  Stream<NotesState> _mapAddNoteToState(AddNote event) async* {
    _firebaseNote.addNewNote(event.note);
  }

  Stream<NotesState> _mapUpdateNoteToState(UpdateNote event) async* {
    _firebaseNote.updateNote(event.updatedNote);
  }

  Stream<NotesState> _mapDeleteNoteToState(DeleteNote event) async* {
    _firebaseNote.deleteNote(event.note);
  }

  Stream<NotesState> _mapTodosUpdateToState(NotesUpdated event) async* {
    yield NotesLoaded(event.notes);
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
